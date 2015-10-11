import Foundation

public class MemoryCache: CacheAware {
  public let prefix = "no.hyper.Cache.Memory"

  public var path: String {
    return cache.name
  }

  public var maxSize: UInt = 0 {
    didSet(value) {
      self.cache.totalCostLimit = Int(maxSize)
    }
  }

  public let cache = NSCache()

  public required init(name: String) {
    cache.name = prefix + name
  }

  // MARK: - CacheAware

  public func add<T: Cachable>(key: String, object: T, completion: (() -> Void)? = nil) {
    cache.setObject(object, forKey: key)
  }

  public func object<T: Cachable>(key: String, completion: (() -> Void)) -> T? {
    return cache.objectForKey(key) as? T
  }

  public func remove(key: String, completion: (() -> Void)?) {
    cache.removeObjectForKey(key)
    completion?()
  }

  public func clear() {
    cache.removeAllObjects()
  }
}
