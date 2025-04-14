USE oficina;

-- Cliente
INSERT INTO cliente (Nome, Sobrenome, Tipo_de_cliente, Telefone)
VALUES
('João', 'Silva', 'PF', '11987654321'),
('Maria', 'Oliveira', 'PF', '11999998888'),
('AutoPeças', 'Ltda', 'PJ', '1133224455');

-- Veículos
INSERT INTO veiculo (idCliente, Placa, Modelo, Marca, Ano, Quilometargem)
VALUES
(1, 'ABC1234', 'Civic', 'Honda', 2018, 55000),
(2, 'XYZ5678', 'Onix', 'Chevrolet', 2020, 30000);

-- Equipes
INSERT INTO Equipe (Nome_mecanico, Espicialidade)
VALUES
('Carlos', 'Suspensão'),
('Ana', 'Motor'),
('Rafael', 'Freios');

-- Peças
INSERT INTO Pecas (Descricao, Valorpeca, Estoque)
VALUES
('Pastilha de Freio', 150.00, 'DISPONIVEL'),
('Filtro de Óleo', 35.00, 'DISPONIVEL'),
('Amortecedor Dianteiro', 220.00, 'INDISPONIVEL');

-- Ordem de Serviço
INSERT INTO OrdemServico (idVeiculo, idEquipe, Tipo_Serviço, DataEntrada, DataSaida, DescricaoServico, Status, ValorTotal)
VALUES
(1, 1, 'REVISÃO', '2025-04-10', '2025-04-11', 'Revisão geral do carro', 'CONCLUÍDA', 300.00),
(2, 2, 'CONSERTO', '2025-04-12', NULL, 'Troca do filtro e correção de vazamento', 'EM EXECUÇÃO', 180.00);

-- OrdemServico_Peca
INSERT INTO OrdemServico_Peca (idOrdemServico, idPeca, Quantidade)
VALUES
(1, 1, 1), -- Pastilha de Freio para revisão
(2, 2, 1); -- Filtro de Óleo para conserto

-- Pagamento
INSERT INTO Pagamento (idOrdemServico, FormaPagamento, ValorPago, DataPagamento, StatusPagamento)
VALUES
(1, 'PIX', 300.00, '2025-04-11', 'PAGO'),
(2, 'CARTÃO DE DÉBITO', 180.00, '2025-04-12', 'PENDENTE');

-- Quais clientes já realizaram ordens de serviço?
SELECT DISTINCT c.Nome, c.Sobrenome
FROM cliente c
JOIN veiculo v ON c.idCliente = v.idCliente
JOIN OrdemServico os ON v.idVeiculo = os.idVeiculo;

-- Qual equipe está com ordens em execução?
SELECT e.Nome_mecanico, os.Status
FROM Equipe e
JOIN OrdemServico os ON e.idEquipe = os.idEquipe
WHERE os.Status = 'EM EXECUÇÃO';

-- Quais peças foram utilizadas em cada ordem de serviço?
SELECT os.idOrdemServico, p.Descricao, osp.Quantidade
FROM OrdemServico os
JOIN OrdemServico_Peca osp ON os.idOrdemServico = osp.idOrdemServico
JOIN Pecas p ON osp.idPeca = p.idPeca;



