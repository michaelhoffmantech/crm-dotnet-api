#!/bin/bash 

#===============================================================================
#          FILE: sln.sh
#         USAGE: ./sln.sh [SOLUTION_NAME]
#   DESCRIPTION: Scaffolds an onion-architecture dotnet solution
#===============================================================================

set -o nounset                              

SOLUTION_NAME=$1
FRAMEWORK="net6.0"
SOURCE_DIR="Source"
TEST_DIR="Testing"
API_LIB="Api"
CLASS_LIBS=( "Application" "Common" "Domain" "Integration" "Persistence" )
PROJECTS=( )

mkdir $SOLUTION_NAME
cd $SOLUTION_NAME

curl -O https://raw.githubusercontent.com/dotnet/core/master/.gitignore

dotnet new sln

mkdir $TEST_DIR
mkdir $SOURCE_DIR

project="$SOURCE_DIR/$SOLUTION_NAME.$API_LIB"
projectFile="$project/$SOLUTION_NAME.$API_LIB.csproj"
PROJECTS+=( $projectFile )

dotnet new webapi -f $FRAMEWORK -o $project

rm $project/WeatherForecast.cs
rm $project/Controllers/WeatherForecastController.cs

for classlib in ${CLASS_LIBS[@]}; do
  project="$SOURCE_DIR/$SOLUTION_NAME.$classlib"
  projectFile="$project/$SOLUTION_NAME.$classlib.csproj"
  PROJECTS+=( $projectFile )
  dotnet new classlib -f $FRAMEWORK -o $project
  rm $project/Class1.cs
done

dotnet sln add ${PROJECTS[*]}
dotnet add ${PROJECTS[0]} reference ${PROJECTS[*]:4:5}
dotnet add ${PROJECTS[1]} reference ${PROJECTS[3]}
dotnet add ${PROJECTS[4]} reference ${PROJECTS[*]:1:2}
dotnet add ${PROJECTS[5]} reference ${PROJECTS[1]} ${PROJECTS[3]}

dotnet restore
