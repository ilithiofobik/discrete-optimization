using JuMP
using GLPK

n = parse(Int, readline())
m = parse(Int, readline())
a = zeros(Int, n, m)

for i in 1:n
    row = [parse(Int, x) for x in split(readline())]
    for j in 1:m
        a[i, j] = row[j]
    end
end

c = [parse(Int, x) for x in split(readline())]
C = [parse(Int, x) for x in split(readline())]

model = Model(GLPK.Optimizer)

# x - the way fuel should be delivered
# x[i, j] = how much fuel is bought from company j for airport i
@variable(model, x[1:n, 1:m] >= 0)

@objective(model, Min, sum(a[i, j] * x[i, j] for i in 1:n, j in 1:m))

for i in 1:n
    # the amount of fuel bought by i-th airport
    @constraint(model, sum(x[i, j] for j in 1:m) == C[i])
end

for j in 1:m
    # maximal amount of fuel supplied by j-th company
    @constraint(model, sum(x[i, j] for i in 1:n) <= c[j])
end

println(model)
optimize!(model)
@show termination_status(model)
@show objective_value(model)
@show value.(x)