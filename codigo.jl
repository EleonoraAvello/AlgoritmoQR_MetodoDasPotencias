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

para encontrar os autovalores
ideia:

seja M a matriz de entrada

1°) M_0 = M
2°) para k = 1, 2, 3, ...
        I) Q_k * R_k = M_{k-1}
        II) M_k = R_k * Q_k

para descobrir os autovetores com base nos autovalores

ideia:
        
seja M a matriz de autovalores
        
Q = Q0 * Q1 * Q2 * ... * Qk
A ≈ Q * Λ * Qt 
        
Q é uma aproximação para a matriz dos autovetores ortonormais da matriz entrada
"""
function algoritmo_QR(M::Matrix, tol = 1e-10)
    # M deve ser uma matriz quadrada
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
    return M, X, iter
end

# exemplo com uma matriz 3X3 não diagonal:
algoritmo_QR([1 1 1; 1 2 1; 1 1 3])

"""
Seja A a matriz de entrada.

Note que a função retorna o seguinte:

([4.214319743377534 -1.4637636228298152e-11 9.193865354505486e-16;
  -1.4638092510092044e-11 1.4608111271891115 -2.0393888880981727e-16;
   2.8361411921016563e-26 -8.928249488099567e-16 0.3248691294333538], 
   [0.39711254979249055 0.2331919783754827 -0.8876503388264066;
    0.5206573684500141 0.7392387395437184 0.4271322870452688;
    0.7557893406737187 -0.6317812811243654 0.17214785896096121], 24)

A primeira matriz M é tal que cada elemento fora da diagonal principal é menor, 
em módulo, que a tolerância inserida 1e-10 depois de 24 iterações.
Na diagonal principal de M temos aproximações para os autovalores de A.

A segunda matriz X possui os autovetores de A.

Podemos confirmar a validade do resultado obtido verificando que:

A⋅X = X⋅M ↔ A = X⋅M⋅Xᵀ

O que nos diz que X é, de fato, a matriz com os autovetores e M é a matriz com os autovalores.
"""