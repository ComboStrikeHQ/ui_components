declare class _UnderscoreCallbacks_ {
  anyFunction(): any;
}

declare var _cb_: _UnderscoreCallbacks_;

declare class Underscore {
  bind(fn: _cb_.anyFunction, this: any): any;
  debounce(fn: _cb_.anyFunction): _cb_.anyFunction;
  extend(obj0: {}, obj1: {}): {};
  findWhere<T>(list: Array<T>, properties: {}): T;
  first<T>(array: Array<T>): T;
  flatten(array: Array<any>): Array<any>;
  map<T1,T2>(array: Array<T1>): Array<T2>;
  throttle(fn: _cb_.anyFunction, wait: number): _cb_.anyFunction;
  union<T>(a: Array<T>, b: Array<T>): Array<T>;
  without<T>(array: Array<T>, elements: T): Array<T>;
}

declare var _: Underscore;
