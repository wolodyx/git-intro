#!/bin/bash
#set -e
#set -x

LOCAL_REPO=$HOME/projects/cmake
COMMITS_DIR=$PWD/commits
TRAINING_REPOS=$PWD/training_repos

mkdir $COMMITS_DIR $TRAINING_REPOS
cd $LOCAL_REPO
git log --merges --format="format:%H" > merge-commits.txt
while read MERGE_COMMIT
do
    #echo "--> ${MERGE_COMMIT}"
    result=$(git --no-pager log $MERGE_COMMIT -1 --oneline --patch --cc | grep "^diff --cc" | sed 's/diff --cc //g')
    if [ ! -z "${result}" ]
    then
        cat > ${COMMITS_DIR}/${MERGE_COMMIT}.result <<< $result
    fi
done < merge-commits.txt


extract_files()
{
    MERGE_COMMIT=$1
    FILE=$2
    FILE_BASENAME=`basename $FILE`

    cd $LOCAL_REPO
    read var PARENT1_COMMIT PARENT2_COMMIT <<< `git rev-list --parents -n 1 $MERGE_COMMIT`
    read BASE_COMMIT <<< `git merge-base $PARENT1_COMMIT $PARENT2_COMMIT`

    #echo "$BASE_COMMIT $PARENT1_COMMIT $PARENT2_COMMIT $FILE"
    git show $BASE_COMMIT:$FILE > ${OLDPWD}/${FILE_BASENAME}.A 2>/dev/null
    git show $PARENT1_COMMIT:$FILE > ${OLDPWD}/${FILE_BASENAME}.B 2>/dev/null
    git show $PARENT2_COMMIT:$FILE > ${OLDPWD}/${FILE_BASENAME}.C 2>/dev/null

    cd -
    if [ `ls -1 ${FILE_BASENAME}.[ABC] | wc -l` -ne 3 ]; then
        rm -f ${FILE_BASENAME}.*
        return 4
    fi

    if cmp -s ${FILE_BASENAME}.A ${FILE_BASENAME}.B;
    then
      return 1
    fi

    if cmp -s ${FILE_BASENAME}.A ${FILE_BASENAME}.C;
    then
      return 2
    fi

    if cmp -s ${FILE_BASENAME}.B ${FILE_BASENAME}.C;
    then
      return 3
    fi

    return 0
}


create_repo()
{
    git init .

    for file in *.A;
    do
        mv $file "${file%.A}"
        git add "${file%.A}"
    done
    git commit -m "Base commit"

    git checkout -b branching
    for file in *.B;
    do
        mv $file "${file%.B}"
        git add "${file%.B}"
    done
    git commit -m "Branched commit"

    git checkout main
    for file in *.C;
    do
        mv $file "${file%.C}"
        git add "${file%.C}"
    done
    git commit -m "Main commit"
}


for filename in ${COMMITS_DIR}/*.result;
do
    fn=`basename $filename`
    MERGE_COMMIT="${fn%.*}"

    REPO_DIR=$TRAINING_REPOS/$MERGE_COMMIT
    rm -rf $REPO_DIR
    mkdir $REPO_DIR
    cd $REPO_DIR

    while read EXTRACTED_FILE
    do
        base=`basename $EXTRACTED_FILE`
        if [[ $base == .* ]];
        then
            continue
        fi

        extract_files $MERGE_COMMIT $EXTRACTED_FILE
        result=$?
        if [ $result -ne 0 ];
        then
            rm -f `basename ${EXTRACTED_FILE}.`*
        fi
    done < ${filename}

    if [ ! "$(ls -A .)" ];
    then
        cd ..
        rm -rf $REPO_DIR
        continue
    fi

    create_repo
    git merge branching --no-commit
    result=$?
    if [ $result -ne 0 ];
    then
        git reset --merge
        tar -czvf ../$MERGE_COMMIT.tgz ../`basename $REPO_DIR`
    fi

    cd ..
    rm -rf $REPO_DIR

done

