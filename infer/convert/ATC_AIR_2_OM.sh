#!/bin/bash

#
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ============================================================================

soc_version=Ascend310
input_shape="x:1,3,500,500"
# help message
if [[ $1 == --help || $1 == -h ]];then
    echo "usage:bash ./ATC_AIR_2_OM.sh <args>"
    echo "parameter explain:
    --model                  set model place, e.g. --model=../8p_channel_3_sigma_15_rank_0-50_4556.air
    --output                 set the name and place of OM model, e.g. --output=../data/model/channel_3_sigma_15
    --soc_version            set the soc_version, default: --soc_version=Ascend310
    --input_shape            set the input node and shape, default: --input_shape='x:1,3,500,500'
    -h/--help                show help message
    "
    exit 1
fi

for para in "$@"
do
    if [[ $para == --model* ]];then
        model=`echo ${para#*=}`
    elif [[ $para == --output* ]];then
        output=`echo ${para#*=}`
    elif [[ $para == --soc_version* ]];then
        soc_version=`echo ${para#*=}`
    elif [[ $para == --input_shape* ]];then
        input_shape=`echo ${para#*=}`
    fi
done

if [[ $model  == "" ]];then
   echo "[Error] para \"model \" must be config"
   exit 1
fi

if [[ $output  == "" ]];then
   echo "[Error] para \"output \" must be config"
   exit 1
fi

atc \
    --model=${model} \
    --output=${output} \
    --soc_version=${soc_version} \
    --input_shape=${input_shape} \
    --framework=1 \
    --input_format=NCHW