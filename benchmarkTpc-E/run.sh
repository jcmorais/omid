#!/bin/bash
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


# ---------------------------------------------------------------------------------------------------------------------
# Helper functions
# ---------------------------------------------------------------------------------------------------------------------


fileNotFound(){
    echo "bench.jar not found!";
    exit 1;
}

# ---------------------------------------------------------------------------------------------------------------------
# --------------------------------------------- SCRIPT STARTS HERE ----------------------------------------------------
# ---------------------------------------------------------------------------------------------------------------------

SCRIPTDIR=`dirname $0`
cd $SCRIPTDIR;
SCRIPTDIR=`pwd`

# ---------------------------------------------------------------------------------------------------------------------
# Check if jar exists and configure classpath
# ---------------------------------------------------------------------------------------------------------------------

[ ! -f "bench.jar" ] && fileNotFound

KLASSPATH=${SCRIPTDIR}/conf:bench.jar

for jar in ./lib/*.jar; do
    if [ -f "$jar" ]; then
        KLASSPATH=$KLASSPATH:$jar
    fi
done

# ---------------------------------------------------------------------------------------------------------------------
# Parse CLI user args
# ---------------------------------------------------------------------------------------------------------------------

USER_OPTION=$1
shift
case ${USER_OPTION} in
    run)
        java -cp $KLASSPATH -Dlog4j.configuration=file:${SCRIPTDIR}/conf/log4j.properties benchtpce.Run "$@"
        ;;
    *)
        show_help
        ;;
esac
