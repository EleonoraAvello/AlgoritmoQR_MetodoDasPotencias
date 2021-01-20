
# Função para refinar a resposta

function resposta(E::Matrix, M::Matrix, X::Matrix, iter::Int)
  
  mE, nE = size(E)
  println("\n Matriz de Entrada: ")
  for i = 1:mE 
    println( E[i,:] )
  end
  
  mM, nM = size(M)
  println("\n Matriz de Autovalores: ")
  for i = 1:mM 
    println( M[i,:] )
  end

  mX, nX = size(X)
  println("\n Matriz de Autovetores: ")  
  for i = 1:mX 
    println( X[i,:] )
  end

  println("\n Quantidade de Iterações: $iter")

end