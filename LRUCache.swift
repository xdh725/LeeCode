/**
 * Question Link: https://leetcode.com/problems/lru-cache/
 * Primary idea: Use Doubly linked list and hash table to build the LRU cache.
 * Time Complexity: O(1), Space Complexity: O(n)
 *
 */
 
class DoublyLinkedList<K, V>{
    var key: K
    var value: V
    var previous: DoublyLinkedList?
    var next: DoublyLinkedList?
    
    init(_ key: K, _ value: V) {
        self.key = key
        self.value = value
    }
}

class LRUCache<K: Hashable, V> {
    var maxCapacity: Int
    var head: DoublyLinkedList<K, V>
    var tail: DoublyLinkedList<K, V>
    var cache: [K: DoublyLinkedList<K, V>]
    
    init(key: K, value: V, maxCapacity: Int) {
        self.maxCapacity = maxCapacity
        self.cache = [K: DoublyLinkedList<K, V>]()
        self.head = DoublyLinkedList<K, V>(key, value)
        self.tail = DoublyLinkedList<K, V>(key, value)
        self.head.next = self.tail
        self.tail.previous = self.head
    }
    
    func add(_ node: DoublyLinkedList<K, V>){
        let next = head.next
        head.next = node
        node.previous = head
        node.next = next
        next?.previous = node
    }
    
    func remove(_ node: DoublyLinkedList<K, V>){
        let previous = node.previous
        let next = node.next
        previous?.next = next
        next?.previous = previous
    }
    
    func get(_ key: K) -> V?{
        if let node = cache[key]{
            remove(node)
            add(node)
            return node.value
        }
        return nil
    }
    
    func put(_ key: K, _ value: V){
        if let node = cache[key]{
            remove(node)
            cache.removeValue(forKey: key)
        }else if cache.keys.count >= maxCapacity{
            if let leastNode = tail.previous{
                remove(leastNode)
                cache.removeValue(forKey: leastNode.key)
            }
        }
        let newNode = DoublyLinkedList(key, value)
        cache[key] = newNode
        add(newNode)
    }
}
