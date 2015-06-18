require "natto"
task :cal_tfidf => :environment do
  def calculate_similarity_with_hash(hash1,hash2)
    hash3 = hash1.merge(hash2)
    hash3.each do |key,value|
      hash1[key] = 0 if hash1[key].nil?
      hash2[key] = 0 if hash2[key].nil?
    end
    vector1 = hash1.sort.map{|key,val|val}
    vector2 = hash2.sort.map{|key,val|val}
    similarity = cosine_similarity(vector1,vector2)
    return similarity #類似度を返す
  end

  def cosine_similarity(vector1, vector2)
    dp = dot_product(vector1, vector2)
    nm = normalize(vector1) * normalize(vector2)
    dp / nm
  end

  def dot_product(vector1, vector2)
    sum = 0.0
    vector1.each_with_index{ |val, i| sum += val*vector2[i] }
    sum
  end

  def normalize(vector)
    Math.sqrt(vector.inject(0.0){ |m,o| m += o**2 })
  end

  @items = Item.all
  last_item = Item.last
  related_article = {}
  @items.each do |item|
#    for i in item.id..last_item.id
#      related_article[i] = calculate_similarity_with_hash(hash1,hash2)
#    end

  end
end
