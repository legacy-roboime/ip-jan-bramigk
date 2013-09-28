# Algorítimo Genético

Um _algorítimo genético_ é uma heurística de busca que procura imitar a seleção natural
que ocorre no processo evolucionário dos organismos vivos.

Nessa heurística, uma população de soluções (também chamadas de indivíduos ou fenótipos)
para problemas de otimização é evoluída para conseguir soluções melhores.
Cada solução possui um conjunto de propriedades (cromossomos ou genótipos) que podem ser
mutados ou alterados.

Os requerimentos são, típicamente:

- uma representação genética da solução
- uma função de aptidão para avaliação da solução

## O processo

O processo é iniciado com uma população com propriedades geradas aleatóreamente.

A iteração da heurística se da em 3 etapas:

- procriação: indivíduos são pareados e é aplicada a operação de cruzamento (_crossover_)
- mutação: alguns indíviduos são selecionados e é aplicada a operação de mutação (_mutation_)
- seleção: é usada a funçao de aptidão para descartar os indivíduos menos aptos
  restando as soluções que de fato trouxeram alguma melhora.

As condições mais comuns para terminação do processo são as seguintes:

- encontrada uma solução que atende os requisitos mínimos
- número fixo de gerações alcançado
- recursos alocados (tempo ou dinheiro) alcançados
- a melhor solução alcançou um patamar estável em que mais iterações não produzem soluções melhores
- inspeção manual

## Limitações

As limitações mais comuns no emprego de um algorítimo genético são:

- Funções de avaliação computacionalmente caras tornam essa heurística ineficiente.
- Não escala bem com a complexidade, isto é, quando o número de elementos expostos a mutação é grande
  o espaço de busca cresce exponencialmente. Por isso, na prática algorítimos genéticos são usados
  para, por exemplo, projetar uma hélice e não um motor.
- A melhor solução é relativa às outras soluções, por isso o critério de parada não é muito claro
  em alguns problemas.
- Em muitos problemas os algorítimos genéticos tendem a convergir para um ótimo local ou as vezes pontos
  arbitrários em vez do ótimo global.
- É difícil aplicar algorítimos genéticos para conjunto de dados dinâmicos. Pois as soluções podem começar
  a convergir para um conjunto de dados que já não é mais válido.
- Algorítimos genéticos não conseguem resolver eficientemente problemas em que a avaliação é binária (certo/errado),
  como em problemas de decisão. Nesse caso buscas aleatórias convergem tão rápido quanto essa heurística.
- Para problemas mais específicos existem outras heurísticas que encontram a solução mais rapidamente.

## Referências

- [Genetic Algorithm](http://en.wikipedia.org/wiki/Genetic_algorithm)
