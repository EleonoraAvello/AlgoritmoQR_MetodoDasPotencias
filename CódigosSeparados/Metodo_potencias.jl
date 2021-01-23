using LinearAlgebra

function metodo_potencias(E::Matrix, tol = 1e-10, max_iter = 1000)
    m, n = size(E)
    if m != n
        error("A entrada deve ser uma matriz quadrada")
    end
    iter = 0
    erro = tol + 1
    # criando o vetor chute inicial y0 = [1, 0, 0, ..., 0]
    y0 = zeros(size(E)[1], 1)
    y0[1] = 1
    while erro > tol && iter < max_iter
        x = E * y0
        y = x / norm(x)
        erro = abs(abs(dot(y0,y)) - 1)
        # atualizamos y0 e o contador iter
        y0 = y
        iter = iter + 1
    end
    λ = dot(y0, E*y0)
    return λ, y0, iter
  end
  metodo_potencias([1 2; 3 2])