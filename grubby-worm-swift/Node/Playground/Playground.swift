//
//  Playground.swift
//  grubby-worm-swift
//
//  Created by Wayne on 15/5/31.
//  Copyright (c) 2015年 Wayne. All rights reserved.
//

import SpriteKit

class Playground: SKNode {
   
    var size: CGSize
    var tiles: [Tile]
    
    init(size: CGSize) {
        
        self.size = size
        self.tiles = []
        
        super.init()
        
        drawGrid()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawGrid() {
        removeAllChildren()
        tiles.removeAll()
        
        let gridSize = AppTheme.playground_size
        
        let rowFrom = Int(-gridSize.row / 2)
        let colFrom = Int(-gridSize.col / 2)
        
        for i in rowFrom..<(gridSize.row + rowFrom) {
            for j in colFrom..<(gridSize.col + colFrom) {
                let style: TileStyle = ((i + j) % 2 == 0) ? .Normal : .Marble
                let tile = Tile(location: GridSize(row: i, col: j), style: style)
                
                let posX = (AppTheme.tile_interval + tile.size.width) * (CGFloat(i) + 0.5)
                let posY = (AppTheme.tile_interval + tile.size.height) * (CGFloat(j) + 0.5)
                
                tile.position = CGPointMake(posX, posY)
                
                addChild(tile)
                tiles.append(tile)
            }
        }
    }
    
    func tileByLocation(location: Location) -> Tile? {
        var ret: Tile?
        
        for tile in tiles {
            if tile.location.row == location.row && tile.location.col == location.col {
                ret = tile
            }
        }
        
        return ret
    }
    
    func tilesInDirect(tile: Tile, direction: Direction) -> [Tile] {
        var ret = [Tile]()
        
        ret.append(tile)
        
        switch direction {
        case .North:
            var location = tile.location
            for i in 0...4 {
                location.col++
                if let haveTile = tileByLocation(location) {
                    ret.append(haveTile)
                }
            }
            break
        default:
            break
        }
        
        return ret
    }

}
