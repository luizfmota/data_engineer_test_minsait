# Documentação da Solução

## Visão Geral

Esta documentação descreve uma solução open-source para processar arquivos no padrão HL7 FHIR (em formato JSON), armazená-los em um banco de dados relacional e disponibilizá-los para consultas analíticas e visualização. A arquitetura é projetada para ser executada localmente, atendendo às restrições de não utilizar serviços em nuvem ou ferramentas pagas.

**Objetivo**: Responder perguntas analíticas como "Quais são as 10 condições mais comuns?", "Quais são os 10 medicamentos mais prescritos?" e "Quantos pacientes são do sexo masculino?" a partir de dados.

**Data Atual**: 14 de março de 2025.

---

## Arquitetura

A solução segue um pipeline ETL com os seguintes componentes:

1. **Ingestão de Dados**: Scripts Python para ler arquivos JSON.
2. **Transformação**: Normalização dos dados em tabelas relacionais.
3. **Armazenamento**: Banco de dados PostgreSQL.
4. **Visualização**: Ferramenta de BI Metabase.

### Diagrama da Arquitetura

```
 _______________       ___________________       ____________       __________
[               ]     [                   ]     [            ]     [          ]
[ Arquivos JSON ] --> [ Script Python ETL ] --> [ PostgreSQL ] --> [ Metabase ]
[_______________]     [___________________]     [____________]     [__________]
```

- **Arquivos padrão HL7 FHIR JSON**: Dados brutos na pasta `data`.
- **Script Python ETL**: Processa os arquivos e carrega os dados no banco.
- **PostgreSQL**: Armazena os dados em tabelas otimizadas.
- **Metabase**: Interface para consultas SQL e dashboards.

---

## Ferramentas Utilizadas

Todas as ferramentas são open-source e podem ser executadas localmente:

| Ferramenta       | Função                          | Justificativa                                  |
|------------------|---------------------------------|------------------------------------------------|
| **Python**       | Pipeline ETL                   | Flexível para manipular JSON e integrar com DB |
| **PostgreSQL**   | Banco de dados relacional      | Robusto, escalável e otimizado para análises   |
| **Metabase**     | Visualização e consultas       | Interface amigável, suporta SQL nativo         |

---

## Estrutura do Banco de Dados

Os dados FHIR são normalizados em tabelas relacionais para otimizar consultas. Abaixo estão as principais tabelas propostas:

### Tabela: `patients` (entry.resource.resourceType == Patient)
| Coluna       | Tipo         | Descrição                      |
|--------------|--------------|--------------------------------|
| `id`         | VARCHAR(50) | Chave primária                 |
| `gender`     | VARCHAR(50)  | Gênero (`male`, `female`, etc.)|
| `birth_date` | DATE         | Data de nascimento             |

### Tabela: `conditions` (entry.resource.resourceType == Condition)
| Coluna          | Tipo         | Descrição                          |
|-----------------|--------------|------------------------------------|
| `id`            | VARCHAR(50)  | Chave primária                     |
| `patient_id`    | VARCHAR(50)  | Chave estrangeira (`patients.id`)  |
| `condition_text`| TEXT         | Código/descrição da condição       |
| `recorded_date` | DATE         | Data de registro (se disponível)   |

### Tabela: `medication_requests` (entry.resource.resourceType == MedicationRequest)
| Coluna            | Tipo         | Descrição                          |
|-------------------|--------------|------------------------------------|
| `id`              | VARCHAR(50)  | Chave primária                     |
| `patient_id`      | VARCHAR(50)  | Chave estrangeira (`patients.id`)  |
| `medication_text` | TEXT         | Nome do medicamento                |
| `authored_on`     | DATE         | Data da prescrição (se disponível) |

---

## Consultas SQL

### 10 Condições Mais Comuns
```sql
SELECT condition_text, COUNT(*) as count
FROM conditions
GROUP BY condition_text
ORDER BY count DESC
LIMIT 10;
```

### 10 Medicamentos Mais Prescritos
```sql
SELECT medication_text, COUNT(*) as count
FROM medication_requests
GROUP BY medication_text
ORDER BY count DESC
LIMIT 10;
```

### Pacientes do Sexo Masculino
```sql
SELECT COUNT(*) as male_patients
FROM patients
WHERE gender = 'male';
```

---

## Justificativas Técnicas

- **Python**: Ideal para manipulação de JSON e integração com bancos de dados.
- **PostgreSQL**: Suporta grandes volumes de dados e consultas analíticas com alta performance.
- **Metabase**: Simples de usar, suporta SQL nativo e é open-source.

---
