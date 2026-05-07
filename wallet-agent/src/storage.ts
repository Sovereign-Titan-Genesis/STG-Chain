export class LocalStorage {
  private db: Map<string, any>;

  constructor() {
    this.db = new Map();
  }

  save(key: string, value: any) {
    this.db.set(key, value);
  }

  get(key: string) {
    return this.db.get(key);
  }
}
