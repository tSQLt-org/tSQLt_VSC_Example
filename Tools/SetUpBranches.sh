#!/bin/bash
cd "$(dirname "$0")"
cd ..

git fetch

git fetch origin main:main

# Generate a date-time stamp in the UTC timezone
datetime=$(date -u +'%Y%m%d%H%M%S')

main_branch_name="main$datetime"
git checkout -b "$main_branch_name" origin/main

work_branch_name="work$datetime"
git checkout -b "$work_branch_name"

git checkout "$main_branch_name"

# Create the changes of the other employee
cp NotAProject/dbo.RevisionReport.sql Demo/dbo.RevisionReport.sql
cp NotAProject/RevisionReportTests.sql Tests/RevisionReportTests.sql
git add Demo/dbo.RevisionReport.sql Tests/RevisionReportTests.sql
git commit -m "Created Revision Report"

# Push the branches
git push -u origin "$main_branch_name"
git push -u origin "$work_branch_name"

# Checkout the work branch
git checkout "$work_branch_name"

# git merge "$main_branch_name" --no-edit
# git push

