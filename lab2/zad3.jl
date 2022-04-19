using JuMP
import LinearAlgebra
using GLPK

n, m = [parse(Int, x) for x in split(readline())]

l = zeros(n + 1, m + 1, n + 1, m + 1)
u = zeros(n + 1, m + 1, n + 1, m + 1)

for i in 1:n
    h = [parse(Int, x) for x in split(readline())]
    for j in 1:m
        l[n+1, j, i, j] = h[j]
        l[i, j, i, m+1] = h[j]
    end
end

for i in 1:n
    h = [parse(Int, x) for x in split(readline())]
    for j in 1:m
        u[n+1, j, i, j] = h[j]
        u[i, j, i, m+1] = h[j]
    end
end

c = [parse(Int, x) for x in split(readline())]
C = [parse(Int, x) for x in split(readline())]

for i in 1:n
    l[i, m+1, n+1, m+1] = c[i]
end

for j in 1:m
    l[n+1, m+1, n+1, j] = C[j]
end

model = Model(GLPK.Optimizer)

# x is a matrix of flows in arcs
# x[a,b,c,d] represents how many police cars flows from (a,b) to (c,d)
# every police car flows through (n+1,m+1)
# police cars connected with district j flow through (n + 1, j)
# police cars connected with shift i flow through (i, m + 1)
@variable(model, x[1:n+1, 1:m+1, 1:n+1, 1:m+1])

# police cars can flow only through existing arcs, so the arcs with lower bound 
@constraint(model, [a = 1:n+1, b = 1:m+1, c = 1:n+1, d = 1:m+1; l[a, b, c, d] == 0], x[a, b, c, d] == 0)

# all nodes are transshipment nodes 
@constraint(model, [a = 1:n+1, b = 1:m+1], sum(x[a, b, :, :]) == sum(x[:, :, a, b]))

# there are upper bounds for every pair of shift and district
@constraint(model, [a = 1:n+1, b = 1:m+1, c = 1:n+1, d = 1:m+1; u[a, b, c, d] > 0], x[a, b, c, d] <= u[a, b, c, d])

# there are lower bounds for every pair of shift and district, every shift and every district
@constraint(model, [a = 1:n+1, b = 1:m+1, c = 1:n+1, d = 1:m+1; l[a, b, c, d] > 0], x[a, b, c, d] >= l[a, b, c, d])

@objective(model, Min, sum(x[i, m+1, n+1, m+1] for i in 1:n))

println(model)
optimize!(model)
@show termination_status(model)
@show objective_value(model)
@show value.(x)