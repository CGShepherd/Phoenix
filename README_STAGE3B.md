# Project Phoenix — Stage 3B consolidated batch

Extract into the repository root, then run:

    tools\run_stage3b_batch.bat

The runner now copies every LTspice-generated `.log` into `test/results/stage3b_batch`
and concatenates those measurement logs into one master file automatically.

Return:

    test\results\stage3b_batch\PHX_STAGE3B_MASTER.log

If any deck fails, also return its `.stdout.log`.
