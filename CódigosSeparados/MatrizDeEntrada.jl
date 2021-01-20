include("Algoritmo_QR.jl")

# A função deverá ser chamado no terminal com a matriz que se 
# deseja obter os autovalores e autovetores respectivos

# Chamada de exemplo: matrizDeEntrada([1 1 1; 1 2 1; 1 1 3])

function matrizDeEntrada(E::Matrix)
  
  algoritmo_QR(E)
  
end

# Outro teste: matrizDeEntrada([1 2 1; 6 -1 0; -1 -2 -1])