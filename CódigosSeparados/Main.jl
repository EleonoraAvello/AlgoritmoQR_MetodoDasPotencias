include("Algoritmo_QR.jl")

# A função deverá ser chamado no terminal com a matriz que se 
# deseja os respectivos resultados

# Chamada de exemplo: autovalores([1 1 1; 1 2 1; 1 1 3])

function autovalores(E::Matrix)
  E, M, X, iter = algoritmo_QR(E)
  return M
end

function autovaloresRef(E::Matrix)
  E, M, X, iter = algoritmo_QR(E)
  m, n = size(M)
  for i = 1:m
    for j = 1:n 
      if M[i,j] < 10e-10
        M[i,j] = 0.0
      end
    end
    println(M[i,:])
  end
end

function autovetores(E::Matrix)
  E, M, X, iter = algoritmo_QR(E)
  return X
end

function autovetoresRef(E::Matrix)
  E, M, X, iter = algoritmo_QR(E)
  m, n = size(X)
  for i = 1:m
    for j = 1:n 
      if X[i,j] < 10e-10
        X[i,j] = 0.0
      end
    end
    println(X[i,:])
  end
end

function iteracoes(E::Matrix)
  E, M, X, iter = algoritmo_QR(E)
  return iter
end

function tudo(E::Matrix)
  E, M, X, iter = algoritmo_QR(E)
  return E, M, X, iter
end 

function tudoRef(E::Matrix)
  E, M, X, iter = algoritmo_QR(E)

  mE, nE = size(E)
  for i = 1:mE
    println(E[i,:])
  end
  
  println("")
  mM, nM = size(M)
  for i = 1:mM
    for j = 1:nM
      if M[i,j] < 10e-10
        M[i,j] = 0.0
      end
    end
    println(M[i,:])
  end

  println("")
  mX, nX = size(X)
  for i = 1:mX
    for j = 1:nX
      if X[i,j] < 10e-10
        X[i,j] = 0.0
      end
    end
    println(X[i,:])
  end

  println("")
  println(iter)
end