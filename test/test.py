class Topo(object):
  def __init__(self):
    self.nodes = [[16,1], [15,1], [15,6], [14,7], [15,20], [14,10], [14,14], [14,11]]

  def printGrid(self):
    grid = [['....' for i in xrange(20)] for i in xrange(20)]
    for nd in self.nodes:
      x, y = nd[0], nd[1]
      grid[x-1][y-1] = str(x)+str(y) 

    for row in grid:
      print ''.join(row)

if __name__ == '__main__':
  t = Topo()
  t.printGrid()

