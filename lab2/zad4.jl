using JuMP
using GLPK

n, m, k, b = [parse(Int, x) for x in split(readline())]

boxes = falses(n, m)

for i in 1:b
    i, j = [parse(Int, x) for x in split(readline())]
    boxes[i, j] = true
end

model = Model(GLPK.Optimizer)

# c is a matrix reperesenting cameras
# c[i,j] equals the number of cameras in square ij
@variable(model, c[1:n, 1:m] >= 0, Int)

# if a box stands in a square, there cannot be a camera
@constraint(model, [i in 1:n, j in 1:m; boxes[i, j]], c[i, j] == 0)

# every box must be observed by at least one camera in its surroundings
# camera cannot be more than k squares away from the box
@constraint(model, [i in 1:n, j in 1:m; boxes[i, j]],
    sum(c[i, l] for l in max(1, j - k):min(m, j + k)) +
    sum(c[l, j] for l in max(1, i - k):min(n, i + k)) >= 1)

@objective(model, Min, sum(c[i, j] for i in 1:n, j in 1:m))

println(model)
optimize!(model)
@show termination_status(model)
@show objective_value(model)
@show value.(c)
println(boxes)