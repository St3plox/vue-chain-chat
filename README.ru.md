# vue-chat

Languages

- [English](README.md)
- [Русский](README.ru.md)

Этот проект создан для обучения. Он представляет собой простой веб-мессенджер, разработанный с использованием Vue.js и Web3. Пользователи могут аутентифицироваться через MetaMask и отправлять сообщения с собственных адресов. Сообщения хранятся в блокчейне Ethereum с использованием смарт-контракта на Solidity.

P.S. Это мой первый опыт работы с Vue и Solidity



## Настройка проекта

```sh
npm install
```

### Запуск dev-сервера:

```sh
npm run dev
```

### Подключение MetaMask:
Убедитесь, что у вас установлено расширение MetaMask в браузере. Добавьте свой аккаунт MetaMask, импортировав его из Hardhat. Для этого выполните следующие шаги:

1) Запустите команду 
```sh
npx hardhat node
```

2) Скопируйте один из адресов, сгенерированных в консоли
3) Откройте MetaMask, нажмите на значок аккаунта и выберите "Импортировать аккаунт"
4) Вставьте скопированный адрес в поле для импорта

### Подключение к тестовой сети
1) В MetaMask выберите раскрывающееся меню сети и нажмите "Пользовательский RPC"
2) Введите URL RPC и Chain ID тестовой сети (обычно 31337)
3) Нажмите "Сохранить", чтобы подключиться к тестовой сети

### Деплой смарт-контракта
```sh
npx hardhat run scripts/deploy.js
```

### Взаимодействие с чатом
После деплоя контракта и подключения MetaMask к нужной сети вы можете взаимодействовать с чат-приложением. Пользователи могут аутентифицироваться через MetaMask и отправлять сообщения с собственных адресов.

### Компиляция

```sh
npm run build
```

### Линтинг с [ESLint](https://eslint.org/)

```sh
npm run lint
```
