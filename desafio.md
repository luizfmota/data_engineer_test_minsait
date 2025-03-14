![Logo Minsait](imgs/logo_minsait.jpg)
***
# Teste Técnico
## Engenheiro de Dados Pleno

### Introdução
Este teste é direcionado para profissionais que desejam atuar como Engenheiro de Dados Pleno na Minsait. 

O processo seletivo prevê a contratação de 1 profissional para atuação em projetos de Big Data e Engenharia de Dados na [Secretaria de Estado da Saúde de Goiás](https://www.saude.go.gov.br/).

### Contextualização
Na pasta `data` deste repositório há 1.180 arquivos JSON. Cada arquivo representa a história clínica de um paciente fictício no padrão HL7 FHIR.

## Objetivo
Planejar e implementar uma arquitetura que permita a realização de análises e criação de dashboards a partir desses dados. A solução deve prover uma interface que possibilite consultas aos dados de forma agregada por um Analista de BI ou Cientista de Dados.

Preferencialmente, a arquitetura deve permitir a consulta aos dados por meio de SQL em uma ferramenta de visualização de dados (como Metabase, Superset, Power BI e outros).

Por meio dessa interface, deve ser possível responder perguntas como:

### Quais são as 10 condições médicas mais comuns? 
Contagem de `entries` onde o `resource.resourceType` é "Condition", agrupando pela condição (`resource.code.text`), ordenando do maior para o menor número de ocorrências, limitando a 10 resultados.

### Quais são os 10 medicamentos mais prescritos?
Contagem de `entries` onde o `resource.resourceType` é "MedicationRequest", agrupando pelo medicamento (`resource.medicationCodeableConcept.text`), ordenando do maior para o menor número de prescrições, limitando a 10 resultados.

### Quantos pacientes são do sexo masculino?
Contagem de `entries` onde o `resource.resourceType` é "Patient" e o sexo (`resource.gender`) é "male".

### Restrições Técnicas
- Todas as ferramentas e tecnologias utilizadas na arquitetura devem ser de código aberto (open source)
- A solução deve ser executada localmente, em ambiente on-premise
- Não é permitido o uso de serviços em nuvem (AWS, Azure, GCP, etc)

### Observações Adicionais
- Considere que o volume de dados pode crescer para a casa de centenas de milhões de registros.
- Cada consulta não deve levar mais do que poucos segundos para ser processada.
- Além do código, é importante apresentar a documentação da arquitetura (diagramas e texto)

## Prazo
O prazo para entrega do teste é de 7 dias corridos a partir da data de envio do mesmo por e-mail.

## Entrega
Todos os artefatos produzidos deverão ser organizados em um repositório público no GitHub vinculado à sua conta pessoal.

Ao final do prazo de entrega do teste, envie o link do repositório com todos os entregáveis para o e-mail [wsmarques@minsait.com](mailto:wsmarques@minsait.com). 

Após o recebimento, caso o resultado seja satisfatório, entraremos em contato para agendar uma reunião (última fase do processo seletivo)