object @category
attributes :id
node(:name) {|category| category.names_depth_cache_ir}
