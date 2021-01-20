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