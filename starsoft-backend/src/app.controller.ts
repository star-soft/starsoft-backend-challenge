import { Controller, Get } from '@nestjs/common';

@Controller()
export class AppController {
    @Get()
    getRoot(): string {
        return 'Bem-vindo à API!';
    }

    @Get('test')
    getTest(): string {
        return 'Rota de teste funcionando!';
    }
}