DIRNAME=logs
mkdir -p ${DIRNAME}
export MP_SIZE=${MP_SIZE:-1}
export GPU_NUM=${GPU_NUM:-1}

export run_script="examples/ds_pretrain_gpt2-zero3.sh"
for GPU_NUM in 4 8 2 1
do 
for MP_SIZE in 1 2 
do
for MODEL_SIZE in 6 10 15 20 
do
for BS in 4 8 16 
do
echo "runing ${MODEL_SIZE} ${GPU_NUM} ${BS}"
env NUM_GPUS_PER_WORKER=${GPU_NUM} MP_SIZE=${MP_SIZE} MODEL_SIZE=${MODEL_SIZE} BS=${BS} bash ${run_script} 2>&1 | tee ${DIRNAME}/log.model_${MODEL_SIZE}B_bs_${BS}_gpu_${GPU_NUM}_mp_${MP_SIZE}
done
done
done
done

