-- Tabla: Empleados
CREATE TABLE empleados (
    empleado_id CHAR(10) UNIQUE,
    nombre_completo VARCHAR(100) NOT NULL,
    dni VARCHAR(8) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    cargo VARCHAR(100),
    fecha_ingreso DATE,
    direccion TEXT,
    distrito VARCHAR(50),
    estado VARCHAR(20),
    PRIMARY KEY (empleado_id)
);

-- Tabla: Segmento
CREATE TABLE segmento (
    segmento_id CHAR(5) UNIQUE,
    nombre_segmento VARCHAR(100),
    PRIMARY KEY (segmento_id)
);

-- Tabla: Tipo Cliente
CREATE TABLE tipo_cliente (
    tipo_cliente_id CHAR(5) UNIQUE,
    segmento_id CHAR(5),
    nombre_tipo_cliente VARCHAR(100),
    PRIMARY KEY (tipo_cliente_id),
    FOREIGN KEY (segmento_id) REFERENCES segmento(segmento_id)
);

-- Tabla: Clientes
CREATE TABLE clientes (
    cliente_id CHAR(10) UNIQUE,
    tipo_cliente_id CHAR(5),
    nombre_razon_social VARCHAR(100),
    ruc_dni VARCHAR(11) UNIQUE,
    telefono VARCHAR(20),
    email VARCHAR(100),
    fecha_registro DATE,
    estado VARCHAR(20),
    PRIMARY KEY (cliente_id),
    FOREIGN KEY (tipo_cliente_id) REFERENCES tipo_cliente(tipo_cliente_id)
);

-- Tabla: Contratistas
CREATE TABLE contratistas (
    contratista_id CHAR(10) UNIQUE,
    nombre_razon_social VARCHAR(100),
    ruc_dni VARCHAR(11) UNIQUE,
    tipo_contratista VARCHAR(50),
    telefono VARCHAR(20),
    email VARCHAR(100),
    direccion TEXT,
    distrito VARCHAR(50),
    estado VARCHAR(20),
    PRIMARY KEY (contratista_id) 
);

-- Tabla: Contratos
CREATE TABLE contratos (
    contrato_id CHAR(15) UNIQUE,
    cliente_id CHAR(10),
    empleado_id CHAR(10),
    nombre_proyecto VARCHAR(100),
    direccion TEXT,
    distrito VARCHAR(50),
    fecha_inicio DATE,
    fecha_fin_estimado DATE,
    fecha_entrega_real DATE,
    monto_total DECIMAL(12,2),
    estado VARCHAR(50),
    penalidad_dia DECIMAL(5,2),
    PRIMARY KEY (contrato_id),
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
    FOREIGN KEY (empleado_id) REFERENCES empleados(empleado_id)
);

-- Tabla: Subcontratos
CREATE TABLE subcontratos (
    subcontrato_id CHAR(15) UNIQUE,
    contrato_id CHAR(15),
    contratista_id CHAR(10),
    monto_acordado DECIMAL(12,2),
    fecha_inicio DATE,
    fecha_fin_estimada DATE,
    fecha_entrega_real DATE,
    PRIMARY KEY (subcontrato_id),
    FOREIGN KEY (contrato_id) REFERENCES contratos(contrato_id),
    FOREIGN KEY (contratista_id) REFERENCES contratistas(contratista_id)
);

-- Tabla: Pagos a Contratistas
CREATE TABLE pagos_contratistas (
    pago_id CHAR(10) UNIQUE,
    subcontrato_id CHAR(15),
    fecha_pago DATE,
    comprobante_pago VARCHAR(100),
    PRIMARY KEY (pago_id),
    FOREIGN KEY (subcontrato_id) REFERENCES subcontratos(subcontrato_id)
);

-- Tabla: Penalidades
CREATE TABLE penalidades (
    penalidad_id CHAR(10) UNIQUE,
    contrato_id CHAR(15),
    dias_retraso INT CHECK (dias_retraso >= 0),
    monto_penalidad DECIMAL(12,2),
    PRIMARY KEY (penalidad_id),
    FOREIGN KEY (contrato_id) REFERENCES contratos(contrato_id),
);






