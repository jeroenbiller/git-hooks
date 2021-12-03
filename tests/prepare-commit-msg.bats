#!/usr/bin/env bats

file="tmp.txt"

function setup() {
  cp -r ../hooks/. ./ 
  touch $file 
}

function teardown() {
  rm $(ls | grep -v "bats")
}

@test "correct commit message" {
  echo "BILLDEV-999 My clean commit message" > $file
  BRANCH_NAME="BILLDEV-999-refactor-some-thing" ./prepare-commit-msg $file
  [ "$(cat $file)" == "BILLDEV-999 My clean commit message" ]
}

@test "no capitalized sentence" {
  echo "BILLDEV-999 my clean commit message" > $file
  BRANCH_NAME="BILLDEV-999-refactor-some-thing" ./prepare-commit-msg $file
  [ "$(cat $file)" == "BILLDEV-999 My clean commit message" ]
}

@test "without ticket number" {
  echo "My clean commit message" > $file
  BRANCH_NAME="BILLDEV-999-refactor-some-thing" ./prepare-commit-msg $file
  [ "$(cat $file)" == "BILLDEV-999 My clean commit message" ]
}

@test "ticket number with brackets" {
  echo "[BILLDEV-999] My clean commit message" > $file
  BRANCH_NAME="BILLDEV-999-refactor-some-thing" ./prepare-commit-msg $file
  [ "$(cat $file)" == "BILLDEV-999 My clean commit message" ]
}

@test "with period at the end" {
  echo "[BILLDEV-999] My clean commit message." > $file
  BRANCH_NAME="BILLDEV-999-refactor-some-thing" ./prepare-commit-msg $file
  [ "$(cat $file)" == "BILLDEV-999 My clean commit message" ]
}

@test "branch name prepended" {
  echo "My clean commit message" > $file
  BRANCH_NAME="feature/BILLDEV-999-refactor-some-thing" ./prepare-commit-msg $file
  [ "$(cat $file)" == "BILLDEV-999 My clean commit message" ]
}

@test "branch without ticket number" {
  echo "My clean commit message" > $file
  BRANCH_NAME="refactor-some-thing" ./prepare-commit-msg $file
  [ "$(cat $file)" == "My clean commit message" ]
}