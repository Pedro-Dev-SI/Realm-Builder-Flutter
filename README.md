# Realm Builder Flutter

Este é um aplicativo desenvolvido em Flutter que permite aos usuários cadastrar, visualizar e editar jogos e personagens.

## Execução do APP
Para executar a aplicação, o servidor deve estar rodando.

### URL's

No arquivo globals.dart, ajuste as urls conforme o seu ip local.

const String baseGameURL = "http://{seu ip}:8080/api/game";
const String baseCharacterURL = "http://{seu ip}:8080/api/characters";
const Map<String, String> headers = {"Content-Type": "application/json"};

A api em spring roda por padrão na porta 8080.

### Emulador
É importante ter um emulador já configurado em seu ambiente para rodar o app.

Segue os passos no vscode para inicialização do app:
**Run -> Run without debugging**
