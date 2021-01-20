using LinearAlgebra

include("Fatoracao_QR.jl")
include("Resposta.jl")

function algoritmo_QR(E::Matrix, tol = 1e-10)
    # E deve ser uma matriz quadrada
    M = deepcopy(E)
    m, n = size(M)
    if m != n
        error("A entrada deve ser uma matriz quadrada")
    end
    X = I
    iter = 0
    diagonal = false
    while diagonal == false
        if iter == 1000
            break
        end
        # verificamos se M é diagonal
        diagonal = true
        for i in 1:m
            for j in 1:n
                if i != j && abs(M[i,j]) > tol
                    diagonal = false
                end
                if i != j && abs(M[i,j]) < tol
                    M[i,j] = 0.0  
                end
            end
        end
        # se M não é diagonal, então
        # I) calculamos a fatoração QR de M
        Q, R = fatoracao_QR(M)
        # II) M = R * Q
        M = R * Q
        # multiplicando para obter a matriz X de autovetores no fim do processo
        X = X * Q
        iter = iter + 1
    end
  resposta(E, M, X, iter)
end