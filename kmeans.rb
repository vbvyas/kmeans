# Input a list of coordinates {x: 1, y: 2}, k the desired number of clusters
# and the desired number of iterations
# Returns a list of clusters
# Algorithm : http://nlp.stanford.edu/IR-book/html/htmledition/k-means-1.html
# TODO: Take n dimensional points instead of 2 only
def kmeans(points, k, iterations)
  # assign random clusters
  centroids = random_initial_centroids(points, k)
  
  iterations.times do
    # Initialize clusters
    clusters = []
    (0...k).each do |i|
      clusters[i] = []
    end
    
    points.each do |p|
      clusters[closest_centroid(p, centroids)] << p
    end
    
    # Calculate new centroid
    new_centroids = []
    clusters.each do |cluster|
      new_centroids << calculate_centroid(cluster) unless cluster.nil?
    end
    
    centroids = new_centroids
  end
  
  clusters
end

def random_initial_centroids(points, k)
  centroids = []
  (0...k).each do |i|
    centroids[i] = points[rand(0...points.length)]
  end
  
  centroids
end

# Returns the index of the closest centroid given a point
# argmin from the algorithm
def closest_centroid(point, centroids)
  min = Float::INFINITY
  min_index = 0
  
  centroids.each.with_index do |centroid, i|
    dist = euclidean_distance(point, centroid)
    if dist < min
      min = dist
      min_index = i
    end
  end
  
  min_index
end

# Calculate centroid of list of points
def calculate_centroid(points)
  sum_x = 0
  sum_y = 0
  
  points.each do |p|
    sum_x += p[:x]
    sum_y += p[:y]
  end
  n = points.length
  {x: sum_x / n, y: sum_y / n}
end

def euclidean_distance(a, b)
  (a[:x] - b[:x]) ** 2 + (a[:y] - b[:y]) ** 2
end

