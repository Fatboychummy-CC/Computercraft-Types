---@meta

--[[
  #####################
  EXTRAS
  #####################
]]

---@class HexColor : integer A hex integer (ie 0xabcdef01)

---@class Number3 : {[1]:number,[2]:number,[3]:number} A table holding three numbers.
---@class Number2 : {[1]:number,[2]:number} A table holding two numbers.

---@generic T
---@class lua_array : {[integer]:T}

---@generic T
---@class lua_dictionary : {[string]:T}

--[[
  #####################
  PERIPHERALS
  #####################
]]

--[[
  shorthand to include all modules
]]

---@class plethora_all_modules : plethora_scanner, plethora_glasses, plethora_laser, plethora_kinetic, plethora_intro_sensor, plethora_chat

--[[
  module container
]]

---@class plethora_module_container
---@field filterModules fun(names:...<string>):lua_dictionary<function>? Gets the methods which require these modules.
---@field hasModule fun(module:string):boolean Checks whether a module is available.
---@field listModules fun():lua_array<string> Lists all modules available.

--[[
  plethora:chat
]]

---@class plethora_chat_creative
---@field capture fun(pattern:string) Capture all chat messages matching a Lua pattern, preventing them from being said.
---@field clearCaptures fun() Remove all listeners added by capture().
---@field say fun(message:string) Send a message to everyone.
---@field uncapture fun(pattern:string):boolean Remove a capture added by capture(pattern).

---@class plethora_chat : plethora_chat_creative
---@field tell fun(message:string) Send a message to yourself.

--[[
  plethora:glasses
]]

---@class plethora_glasses
---@field canvas fun() Get the 2D canvas for these glasses.
---@field canvas3d fun() Get the 3D canvas for these glasses.

---@class plethora_glasses_base_object
---@field remove fun() Remove this object from the canvas.

---@class Scalable
---@field getScale fun():number Get the scale of this object.
---@field setScale fun(scale:number) Set the scale of this object.

---@class DepthTestable
---@field isDepthTested fun(): boolean Determine whether depth testing is enabled for this object.
---@field setDepthTested fun(depthTest:boolean) Set whether depth testing is enabled for this object.

---@class Colourable
---@field getAlpha fun():integer Get the alpha for this object.
---@field getColor fun():HexColor Get the color of this object.
---@field setAlpha fun(alpha:integer) Set the alpha for this object.
---@field setColor fun(r:HexColor|integer, g:integer?, b:integer?, alpha:integer?) Set the color for this object.
local Colourable = {}
Colourable.getColour = Colourable.getColor
Colourable.setColour = Colourable.setColor

---@class ObjectGroup
---@field clear fun() Remove all objects.

---@class MultiPoint2D
---@field getPoint fun(idx:integer):number, number Get the specified vertex of this object.
---@field setPoint fun(idx:integer, x:number, y:number) Set the specified vertex of this object.

---@class MultiPointResizable2D : MultiPoint2D
---@field getPointCount fun():integer Get the number of verticies in this object.
---@field insertPoint fun(idx:integer, x:number, y:number) Add a vertex to this object.
---@field removePoint fun(idx:integer) Remove the specified vertex of this object.

---@class Positionable2D
---@field getPosition fun():number, number Get the position of this object.
---@field setPosition fun(x:number, y:number) Set the position of this object.

---@class Group2D : ObjectGroup
---@field addDot fun(position:Number2, color:HexColor?, size:number?): Dot2D Create a new dot.
---@field addGroup fun(position:Number2): Group2D Create a new object group.
---@field addItem fun(position:Number2, item:string, scale:number?): Item2D Create a new item icon.
---@field addLine fun(start:Number2, end:Number2, color:HexColor?, thickness:number?): Line2D Create a new line.
---@field addLines fun(points:...<Number2>, color:HexColor?, thickness:number?): MultiPointResizable2D Create a new line loop, composed of many points.
---@field addPolygon fun(points:...<Number2>, color:HexColor?): MultiPointResizable2D Create a new polygon, composed of many points.
---@field addRectangle fun(x:number, y:number, width:number, height:number, color:HexColor?): Rectangle2D Create a new rectangle.
---@field addText fun(position:Number2, contents:string, color:HexColor?, size:number?): TextObject Create a new text object.
---@field addTriangle fun(p1:Number2, p2:Number2, p3:Number2, colors:HexColor?): MultiPoint2D Create a new triangle, composed of three points.

---@class Dot2D : Positionable2D, Colourable, Scalable, plethora_glasses_base_object

---@class Line2D : MultiPoint2D

---@class Rectangle2D : Positionable2D, Colourable, plethora_glasses_base_object
---@field getSize fun(): number, number Get the size of this rectangle.
---@field setSize fun(width:number, height:number) Set the size of this rectangle.

---@class ItemObject
---@field getItem fun():string Get the item for this object.
---@field setItem fun(item:string) Set the item for this object.

---@class Item2D : ItemObject, Positionable2D, Scalable, plethora_glasses_base_object

---@class Canvas2D : Group2D, plethora_glasses_base_object A canvas2d object provided by Plethora.

---@class TextObject : plethora_glasses_base_object
---@field getLineHeight fun():integer Get the line height for this object.
---@field getText fun():string Get the text for this object.
---@field hasShadow fun():boolean Get the shadow for this object.
---@field setLineHeight fun(lineHeight:integer) Set the line height for this object.
---@field setShadow fun(shadow:boolean) Set the shadow for this object.
---@field setText fun(contents:string) Set the text for this object.

---@class Frame2D : ObjectGroup, plethora_glasses_base_object
---@field getSize fun():number, number Get the size of this canvas.

---@class Origin3D
---@field create fun(offset:Number3): Canvas3D

---@class ObjectRoot3D
---@field recenter fun(offset:Number3) Recenter this canvas relative to the current position.

---@class Positionable3D
---@field getPosition fun(): x:number, y:number, z:number Get the position of this object.
---@field setPosition fun(x:number, y:number, z:number) Set the position of this object

---@class Rotatable3D
---@field getRotation fun(): x:number?, y:number?, z:number? Get the rotation of this object, or nil if it faces the player.
---@field setRotation fun(x:number?, y:number?, z:number?) Set the rotation of this object, passing nothing if it should face the player.

---@class MultiPoint3D
---@field getPoint fun(idx:integer) Get the specified vertex of this object.
---@field setPoint fun(idx:integer, x:number, y:number, z:number) Set the specified vertex of this object.

---@class Group3D : ObjectRoot3D, ObjectGroup, plethora_glasses_base_object
---@field addBox fun(x:number, y:number, z:number, width:number?, height:number?, depth:number?, color:HexColor?): Box3D
---@field addLine fun(start:Number3, end:Number3, thickness:number?, color:HexColor?): Line3D
---@field addItem fun(position:Number3, item:string, scale:number): Item3D
---@field addFrame fun(position:Number3): Frame2D

---@class Canvas3D : Group3D A canvas3d object provided by Plethora

---@class Box3D : DepthTestable, Positionable3D, Rotatable3D, plethora_glasses_base_object
---@field getSize fun(): number Get the size of this box.
---@field setSize fun(width:number, height:number, depth:number) Set the size of this box.

---@class Line3D : MultiPoint3D, DepthTestable, plethora_glasses_base_object

---@class Item3D : DepthTestable, Positionable3D, Rotatable3D, Scalable, ItemObject, plethora_glasses_base_object

---@class Frame3D : DepthTestable, Positionable3D, ObjectGroup, plethora_glasses_base_object

--[[
  plethora:introspection
]]

---@class plethora_introspection
---@field getEnder fun(): table Get this player's ender chest.
---@field getEquipment fun(): table Get this entity's held item and armor.
---@field getID fun(): string Get this entity's UUID.
---@field getInventory fun(): table Get this player/turtle's inventory.
---@field getName fun(): string Get this entity's name.

--[[
  plethora:introspection AND plethora:sensor
]]

---@class plethora_intro_sensor : plethora_introspection, plethora_sensor
---@field getMetaOwner fun(): table Get metadata about this entity.

--[[
  plethora:kinetic
]]

---@class plethora_kinetic
---@field disableAI fun() Disable the AI of this entity (Warning: Irreversible!).
---@field explode fun() Explode this creeper.
---@field isWalking fun():boolean Whether the entity is currently walking somewhere.
---@field launch fun(yaw:number, pitch:number, power:number) Launch the entity in a set direction.
---@field look fun(yaw:number, pitch:number) Look in a set direction.
---@field propel fun(velocity:number) Propel this minecart along the track.
---@field shoot fun(potency:number) Fire an arrow (or potion) in the direction the skeleton (or witch) is looking.
---@field swing fun():boolean, string? Left-click with this item.
---@field use fun(duration:integer?):boolean, string? Right-click with this item.
---@field teleport fun(x:number, y:number, z:number) Teleport to a position relative to the current one.
---@field walk fun(x:number, y:number, z:number):boolean, string? Walk to a coordinate.
local plethora_kinetic = {}

---@overload fun(yaw:number, pitch:number) Fire a fireball in the specified direction.
function plethora_kinetic.shoot(potency) end

---@alias hand
---| "left" # Left hand
---| "right" # Right hand

---@overload fun(duration:integer?, hand:hand?)
function plethora_kinetic.use(duration) end

--[[
  plethora:laser
]]

---@class plethora_laser
---@field fire fun(yaw:number, pitch:number, potency:number) Fire a laser in a set direction.

--[[
  plethora:scanner
]]

---@class plethora_scanner
---@field getBlockMeta fun(x:integer, y:integer, z:integer): table Get metadata about a nearby block.
---@field scan fun(): table Scan all blocks in the vicinity.

--[[
  plethora:sensor
]]

---@class plethora_sensor
---@field getMetaByID fun(id:string): table? Find a nearby entity by UUID.
---@field getMetaByName fun(name:string): table? Find a nearby entity by name.
---@field sense fun():table Scan for entities in the vicinity.

--[[
  #####################
  BLOCKS AND ETC
  #####################
]]

---@class plethora_object
---@field getMetadata fun():table Get metadata about this object.

---@class plethora_item_handler
---@field drop fun(slot:integer, limit:integer?, direction:string?):integer Drop an item on the ground.
---@field getItem fun(slot:integer):table? Get the item in the specified slot.
---@field getItemMeta fun(slot:integer):table? Get metadata of the item in the specified slot.
---@field list fun():table List all items in this inventory.
---@field pullItems fun(fromName:string, fromSlot:integer, limit:integer?, toSlot:integer?):integer Pull items to this inventory from another inventory.
---@field pushItems fun(toName:string, fromSlot:integer, limit:integer?, toSlot:integer?):integer Push items from this inventory to another inventory.
---@field size fun():integer Get the size of this inventory, in slots.
---@field suck fun(slot:integer?, limit:integer?):integer Suck an item from the ground.

---@class plethora_capability_provider
---@field getTanks fun(side:string?):lua_array<plethora_fluid> Get a list of all tanks on this side.

---@class plethora_fluid_handler
---@field pullFluid fun(fromName:string, limit:integer, fluid:string):integer Pull fluid to this tank from another tank.
---@field pushFluid fun(toName:string, limit:integer, fluid:string):integer Push fluid from this tank to another tank.

---@class plethora_method_collection
---@field getDocs fun(name:string):string|table Get the documentation for all functions or the function specified.
---@field getTransferLocations fun(location:string):lua_array<string> Get a list of available objects which can be transferred to or from.

---@class plethora_brewing_stand : plethora_item_handler, plethora_method_collection
---@field getBrewTime fun():integer Get the brew time remaining.

---@class plethora_furnace : plethora_item_handler, plethora_method_collection
---@field getBurnTime fun():integer Get the number of ticks the current fuel can burn for.
---@field getCookTime fun():integer Get the number of ticks the current item has cooked for.
---@field getRemainingBurnTime fun():integer Get the number of ticks of fuel remaining.

---@class plethora_sign
---@field getSignText fun():lua_array<string> Get each line of text on this sign.
---@field setSignText fun(lines:...<string>) Set the lines of text on this sign.

---@class plethora_item_slot
---@field consume fun() Consume one item from this stack.
---@field drop fun() Drop an item on the ground.
---@field setActive fun(active:boolean?) Set whether this elytra is active or not.

---@class plethora_meta_turtle
---@field turtle _plethora_meta_turtle

---@class _plethora_meta_turtle
---@field color integer
---@field colour integer
---@field fuel integer
---@field left unknown? The peripheral or tool on the side, unclear what the data structure is.
---@field right unknown? The peripheral or tool on the side, unclear what the data structure is.

---@class plethora_meta_block
---@field displayName string
---@field name string
---@field translationKey string

---@class plethora_meta_material
---@field blocksLight boolean
---@field blocksMovement boolean
---@field burns boolean
---@field liquid boolean
---@field opaque boolean
---@field replaceable boolean
---@field requiresTool boolean
---@field solid boolean

---@class plethora_block_state
---@field harvestLevel integer
---@field harvestTool string
---@field material plethora_meta_material
---@field metadata integer
---@field state lua_dictionary<any>

---@class UUID : string

---@class plethora_entity
---@field displayName string
---@field id UUID
---@field motionX number
---@field motionY number
---@field motionZ number
---@field name string
---@field pitch number
---@field yaw number
---@field withinBlock {x:number,y:number,z:number}
---@field x number
---@field y number
---@field z number

---@class plethora_armor
---@field boots plethora_item_slot?
---@field leggings plethora_item_slot?
---@field chestplate plethora_item_slot?
---@field helmet plethora_item_slot?

---@class plethora_entity.living_base : plethora_entity
---@field armor plethora_armor
---@field health number
---@field heldItem plethora_item_slot?
---@field isAirborne boolean
---@field isAlive boolean
---@field isBurning boolean
---@field isChild boolean
---@field isDead boolean
---@field isElytraFlying boolean
---@field isInWater boolean
---@field isOnLadder boolean
---@field isRiding boolean
---@field isSleeping boolean
---@field isSneaking boolean
---@field isSprinting boolean
---@field isWet boolean
---@field maxHealth integer
---@field offhandItem plethora_item_slot?
---@field potionEffects lua_array<string>

---@class plethora_entity.item : plethora_entity
---@field item plethora_item_stack

---@class plethora_entity.sheep : plethora_entity.living_base
---@field woolColor string
---@field woolColour string

---@class plethora_entity.player : plethora_entity.living_base
---@field allowFlying boolean
---@field flySpeed number
---@field food {hunger:integer, hungry:boolean, saturation:integer}
---@field isFlying boolean
---@field walkSpeed number

---@class plethora_item_stack
---@field count integer
---@field displayName string
---@field maxCount integer
---@field name string
---@field nbtHash string?
---@field rawName string

---@class plethora_item_stack.printout
---@field printout _plethora_printout

---@class _plethora_printout
---@field lines lua_array<string>
---@field pages integer
---@field title string
---@field type string

---@class plethora_item_stack.food
---@field heal integer
---@field saturation number

---@class plethora_item_stack.potion
---@field effects _plethora_potion_effects
---@field potion string
---@field potionType string

---@class _plethora_potion_effects
---@field amplifier integer
---@field color HexColor
---@field duration integer
---@field instant boolean
---@field name string

---@class plethora_item_stack.spawn_egg
---@field storedEntity plethora_entity.living_base

---@class plethora_item_stack.tool_class
---@field toolClass lua_dictionary<integer>

---@class plethora_item_stack.enchanted
---@field enchantments lua_array<plethora_enchantment>

---@class plethora_enchantment
---@field fullName string
---@field level integer
---@field name string

---@class plethora_item_stack.computer
---@field computer _plethora_item_computer

---@class _plethora_item_computer
---@field family string
---@field id integer
---@field label string?

---@class plethora_item_stack.ore_dict
---@field ores lua_dictionary<string>

---@class plethora_item_stack.media
---@field media {label:string?, recordTitle:string?}

---@class plethora_item_stack.turtle
---@field turtle _plethora_item_turtle

---@class _plethora_item_turtle
---@field color integer
---@field colour integer
---@field fuel integer
---@field left unknown? The peripheral or tool on the side, unclear what the data structure is.
---@field right unknown? The peripheral or tool on the side, unclear what the data structure is.

---@class plethora_item_stack.material
---@field material string

---@class plethora_item_stack.armor
---@field armorType string
---@field color HexColor
---@field colour HexColor

---@class plethora_item_stack.pocket_computer
---@field pocket _plethora_item_pocket_computer

---@class _plethora_item_pocket_computer
---@field back unknown? The module information for the pocket computer's rear attachment point.
---@field color HexColor
---@field colour HexColor

---@class plethora_item_stack.banner
---@field banner _plethora_item_banner

---@class _plethora_item_banner
---@field color string
---@field colour string
---@field id string
---@field name string

---@class plethora_mob_spawner : plethora_item_stack
---@field spawnedEntities lua_array<unknown> Unclear what the data structure is for spawned entities, though it is most likely plethora_entity.living_base

---@class plethora_sign : plethora_item_stack
---@field lines lua_array<string>

---@class plethora_energy_storage
---@field energy {capacity:integer, stored:integer}

---@class plethora_fluid
---@field amount integer
---@field displayName string
---@field id string
---@field name string
---@field rawName string

---@class plethora_fluid_tank
---@field capacity integer
