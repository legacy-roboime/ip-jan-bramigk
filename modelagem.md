# Modelagem

Pode-se observar que, como os métodos **Algorítmos Genéticos**, ***Simulated Annealing*** e ***Ant Colony Optmization*** necessitam
que um problema de otimazação seja definido. Logo é necessário definir um modelo do problema e uma função associada ao
modelo para serem implementados. Isso implica que é necessário definir a arquitetura da inteligência a ser modelada. Logo,
para que seja possível a modelagem de diferentes inteligências, será necessário analizar a eficiência da otmização de
cada arquitetura para que seja escolhida a mais eficiente.

O método da Lógica Fuzzy também necessita que uma modelagem para o sistema a ser considerado seja definida. Isso também
restringe a generalidade dos modelos que se enquadram nessa modelagem.

Já o a **Rede Neural** define implicitamente a estrutura interna que mnimiza a diferença entre a saída real e a saída desejada.
Entretanto, é necessário definir a topologia mais adequada para o problema em questão. Também, apezar de não ser necessário, pode-se
decompor o problema em subproblemas e "atribuir redes neurais um subconjunto de tarefas que coincidem com suas capacidades inerentes"(pag. 29 HAYKIN, 2001) com
o objetivo de aumentar a adaptabilidade da rede. Apesar de ser uma modelagem para a arquitetura da inteligência a ser mapeada, não representa uma restrição
tão consideravel quando a das abordagens citadas anteriormente.

## Topologia das Redes Neurais
