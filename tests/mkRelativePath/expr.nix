{modulix}: [
    (modulix.mkRelativePath ./. ./.) # empty
    (modulix.mkRelativePath ./. ./example) # single
    (modulix.mkRelativePath ./. ./path/to/file) # deep
    (modulix.mkRelativePath ./path ./path/to/file) # deep with different root
]
