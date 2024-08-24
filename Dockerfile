FROM jupyter/datascience-notebook
MAINTAINER jimdelois@users.noreply.github.com

USER root

RUN apt-get update -yqq && \
    apt-get install -yqq octave gnuplot-qt && \
    apt-get autoclean && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \

COPY ./container/.octaverc /home/$NB_USER/.octaverc
RUN chown $NB_USER:users /home/$NB_USER/.octaverc

USER $NB_UID

RUN conda config --add channels conda-forge && \
    conda install -y octave_kernel && \
    conda install -y texinfo # For the inline documentation (shift-tab) to appear.

WORKDIR /home/$NB_USER/work
