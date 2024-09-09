FROM base_omni

COPY scripts/submit_run_as_arg.sh submit_run_as_arg.sh

ENV FARM_API_KEY="<xxxx-xxxx-xxxx>"
ENV FARM_URL="http://farm.tpe1.local"
ENV FARM_USER="chenyu_ntu"
ENV NUCLEUS_HOSTNAME="nucleus.tpe1.local"