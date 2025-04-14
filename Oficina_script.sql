
-- Criar banco
-- drop database ecommerce;
CREATE DATABASE oficina;
USE oficina;

-- Tabela cliente
CREATE TABLE cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(25) NOT NULL,
    Sobrenome VARCHAR(30) NOT NULL,
    Tipo_de_cliente ENUM('PF','PJ') NOT NULL,
    Telefone VARCHAR(45) NOT NULL
);

-- Tabela Veiúculo
CREATE TABLE veiculo (
    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    idCliente int,
    Placa VARCHAR(10) NOT NULL,
    Modelo VARCHAR(30) NOT NULL,
	Marca VARCHAR(20) NOT NULL,
    Ano INT NOT NULL,
    Quilometargem FLOAT, 
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente) ON DELETE CASCADE
);

-- Tabela equipe 
CREATE TABLE Equipe (
    idEquipe INT AUTO_INCREMENT PRIMARY KEY,
    Nome_mecanico VARCHAR(30) NOT NULL,
    Espicialidade VARCHAR(30) NOT NULL
);

-- Tabela O.S
CREATE TABLE OrdemServico (
    idOrdemServico INT AUTO_INCREMENT PRIMARY KEY,
    idVeiculo INT NOT NULL,
    idEquipe INT NOT NULL,
    Tipo_Serviço ENUM('CONSERTO', 'REVISÃO'),
    DataEntrada DATE NOT NULL,
    DataSaida DATE,
    DescricaoServico TEXT,
    Status ENUM('ABERTA', 'EM EXECUÇÃO', 'CONCLUÍDA', 'CANCELADA') DEFAULT 'ABERTA',
    ValorTotal DECIMAL(10,2),
    FOREIGN KEY (idVeiculo) REFERENCES Veiculo(idVeiculo),
    FOREIGN KEY (idEquipe) REFERENCES Equipe(idEquipe)
);

-- Tabela peça
CREATE TABLE Pecas (
    idPeca INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(100) NOT NULL,
    Valorpeca DECIMAL(10,2) NOT NULL,
    Estoque ENUM('DISPONIVEL', 'INDISPONIVEL')  DEFAULT 'DISPONIVEL'
);

-- Tabela ordem seriços peça 
CREATE TABLE OrdemServico_Peca (
    idOrdemServico INT,
    idPeca INT,
    Quantidade INT NOT NULL,
    PRIMARY KEY (idOrdemServico, idPeca),
    FOREIGN KEY (idOrdemServico) REFERENCES OrdemServico(idOrdemServico) ON DELETE CASCADE,
    FOREIGN KEY (idPeca) REFERENCES Pecas(idPeca) ON DELETE CASCADE
);

-- Tabela de pagamento 
CREATE TABLE Pagamento (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    idOrdemServico INT NOT NULL,
    FormaPagamento ENUM('DINHEIRO', 'CARTÃO DE CRÉDITO', 'CARTÃO DE DÉBITO', 'PIX', 'BOLETO') NOT NULL,
    ValorPago DECIMAL(10,2) NOT NULL,
    DataPagamento DATE NOT NULL,
    StatusPagamento ENUM('PENDENTE', 'PAGO', 'ATRASADO') DEFAULT 'PENDENTE',
    FOREIGN KEY (idOrdemServico) REFERENCES OrdemServico(idOrdemServico) ON DELETE CASCADE
);




