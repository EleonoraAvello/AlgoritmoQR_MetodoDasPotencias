using LinearAlgebra
# função para fazer a fazer a fatoração QR
function fatoracao_QR(A)
    m, n = size(A)
    if m < n
        error("m deve ser ≥ n")
    end
    V = zeros(m,n)
    Q = zeros(m,n)
    R = zeros(n,n)
    # ortogonalizando todos os vetores e armazenando em V
    # v₁ = a₁
    V[:,1] = A[:,1] 
    for j in 2:n
        V[:,j] = A[:,j]
        for i in 1:j-1
            # calculando o coeficiente
            αᵢⱼ = dot(V[:,i], A[:,j]) / dot(V[:,i], V[:,i])
            # ortogonalizando o vetor A[:,j]
            V[:,j] = V[:,j] - αᵢⱼ * V[:,i]
        end
    end
    # normalizando os vetores e armazenando em Q
    for j in 1:n
        norma = sqrt(dot(V[:,j], V[:,j]))
        Q[:,j] = V[:,j] / norma
        # preenchendo R
        R[j,j] = norma
        for i in 1:j-1
            αᵢⱼ = dot(V[:,i], A[:,j]) / dot(V[:,i], V[:,i])
            R[i,j] = αᵢⱼ * sqrt(dot(V[:,i], V[:,i]))
        end
    end
    return Q, R
end
""" 
função para aplicar o Algoritmo QR

ideia:

seja M a matriz de entrada

1°) M_0 = M
2°) para k = 1, 2, 3, ...
        I) Q_k * R_k = M_{k-1}
        II) M_k = R_k * Q_k

"""
function algoritmo_QR(M)
    # M deve ser uma matriz quadrada
    m, n = size(M)
    if m != n
        error("A entrada deve ser uma matriz quadrada")
    end
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
                if i != j && M[i,j] != 0
                    diagonal = false
                end
            end
        end
        # se M não é diagonal, então
        # I) calculamos a fatoração QR de M
        Q, R = fatoracao_QR(M)
        # II) M = R * Q
        M = R * Q
        iter = iter + 1
    end
    return M, iter
end
algoritmo_QR([1 1 1; 1 2 1; 1 1 3])
# ainda não está funcionando, não sei por quê