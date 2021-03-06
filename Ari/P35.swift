//
//  P35.swift
//  Ari
//
//  Created by Hiraku Ohno on 2016/06/16.
//  Copyright © 2016年 Hiraku Ohno. All rights reserved.
//

/*
 Input :
 n
 a
 k
 */


final class P35:Base {

    static func main() {
        P35(a: [1, 2, 4, 7], k: 13).main()
        P35(a: [1, 2, 4, 7], k: 15).main()
    }

    let n: Int
    let a: [Int]
    let k: Int

    fileprivate init(a: [Int], k: Int) {
        self.n = a.count
        self.a = a
        self.k = k

    }

    func main() {
        solve()
    }

    func solve() {
        let result = dfs(0, sum: 0)
        print(result)
    }

    func dfs(_ i: Int, sum: Int) -> Bool {
        guard i != n else {
            return sum == k
        }

        if dfs(i + 1, sum: sum) {
            return true
        }

        if dfs((i + 1), sum: sum + a[i]) {
            return true
        }

        return false

    }
}
