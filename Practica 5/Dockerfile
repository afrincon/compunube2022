FROM jupyter/minimal-notebook

# Install libraries

RUN pip install tensorflow
RUN pip install preprocess1

WORKDIR /notebooks
CMD ["jupyter","notebook", "--allow-root"]