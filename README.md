# EstacionamentoGRP6
O repositório representa um sistema de estacionamento com sensor de entrada e saída, além de monitoramento do nível de alagamento com uma máquina de estado em Verilog.
A seguir, é descrito como realizar a simulação utilizando o arquivo "testbench", o qual contém o módulo "Connect" e as entradas do sistema, assim como os intervalos de tempo. 
Tendo o Quartus Prime Lite Edition aberto com o testbench e arquivo sistema.v compilado já na mesma pasta (com o arquivo sistema.v sendo Top Entity), vá para Assignments > Settings > EDTA Tool Settings > Simulation:
![simulation_testset](https://user-images.githubusercontent.com/100461457/204906926-ea2ab8a9-8c94-4b56-96c2-40f77b1acbb2.png)
Clique em Compile test bench > Test benches:
![2testbench_set](https://user-images.githubusercontent.com/100461457/204906191-e02b9490-0a40-499c-9190-cbefbff2288a.png)
Para criar novo test bench, clique em New. Na imagem, já criamos um para nosso arquivo. Na aba nova aberta ao clicar em "New", coloque o arquivo do testbench e preencha com o nome.
![ultima_testbenchset](https://user-images.githubusercontent.com/100461457/204907033-825f3732-57b6-4ec6-95e0-584180ca9a6e.png)
Tudo isso feito, clique em OK, Apply e OK novamente.
Depois, é apenas ir em Tools > Run Simulation Tool > RTL Simulation. Isso automaticamente abrirá O ModelSim com a simulação. Na aba Waves, encontra-se a simulação dos pulsos das entradas.
![wavess](https://user-images.githubusercontent.com/100461457/204911868-7e814741-47d0-4b4f-916b-617673d36130.png)

Na aba Transcript, tem tudo que é dado em display no arquivo sistema.v.

![Transcript](https://user-images.githubusercontent.com/100461457/204911898-b5a51bb4-829a-40ea-a9f0-5b911657c8b1.png)
