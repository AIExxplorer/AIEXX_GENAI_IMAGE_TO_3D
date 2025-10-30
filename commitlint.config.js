module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat',     // Nova funcionalidade
        'fix',      // Correção de bug
        'docs',     // Alterações na documentação
        'style',    // Formatação, falta de ponto e vírgula, etc
        'refactor', // Refatoração de código
        'perf',     // Melhorias de performance
        'test',     // Adição ou correção de testes
        'build',    // Mudanças no sistema de build ou dependências
        'ci',       // Mudanças em arquivos e scripts de CI
        'chore',    // Outras mudanças que não modificam src ou test
        'revert',   // Reverter um commit anterior
        'wip',      // Work in progress
      ],
    ],
    'subject-case': [0], // Permite qualquer case no subject
  },
};

