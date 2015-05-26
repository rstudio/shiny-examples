This app demonstrates how to exclude points from a computation. You can exclude points from a linear model by clicking on points, or by selecting them with a brush and clicking "Toggle points".

To record the state of which rows of data are kept and which are excluded, we use a `reactiveValues` object containing a logical vector, each element of which represents whether each row is kept or excluded. The reactive value is modified whenever points are clicked or toggled.
