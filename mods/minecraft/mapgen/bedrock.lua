local layer = layer_to_y(0) -- determined as appropriate by cum

minetest.register_on_generated(function(minp, maxp)
	if maxp.y >= layer and minp.y <= layer then
		local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
		local data = vm:get_data()
		local area = VoxelArea:new({MinEdge=emin, MaxEdge=emax})

		for x = minp.x, maxp.x do
			for z = minp.z, maxp.z do
				data[area:index(x, layer, z)] = minetest.get_content_id("minecraft:bedrock")
			end
		end

		vm:set_data(data)
		vm:calc_lighting()
		vm:update_liquids()
		vm:write_to_map()
	end
end)

