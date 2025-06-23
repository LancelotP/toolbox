import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getData(): { message: string; timestamp: string } {
    return { message: 'Hello API', timestamp: new Date().toISOString() };
  }
}
