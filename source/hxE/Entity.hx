package hxE;
import hxE.bits.BitSet;

/**
 * An ENTITY! :o
 * @author P Svilans
 */
class Entity
{
	
	public var id:Int;
	public var bits:BitSet;
	
	private var _isActive:Bool;
	
	public var world:EntityWorld;
	
	/**
	 * Entity constructor. Should be treated as private, and never manually invoked.
	 * Use myEntityWorld.create();
	 * @param	id A unique id for this Entity.
	 */
	
	public function new(id:Int, world:EntityWorld) 
	{
		this.id = id;
		this.world = world;
		
		bits = new BitSet();
		isActive = true;
	}
	
	/**
	 * Deactivate this entity so that it does not get processed by systems.
	 */
	
	public function deactivate():Void
	{
		_isActive = false;
	}
	
	/**
	 * Activate this entity so that it is processed by systems.
	 */
	
	public function activate():Void
	{
		_isActive = true;
	}
	
	/**
	 * Call this everytime you change this entity's components!
	 */
	
	public inline function update():Void
	{
		world.updateEntity(this);
	}
	
	/**
	 * Add a component if it doesn't exist already.
	 * @param	component The component to add.
	 */
	
	public inline function addComponent(component:Component):Void
	{
		world.componentManager.addComponent( this, component);
	}
	
	/**
	 * Check if this entity has the component class.
	 * @param	componentClass The component class.
	 * @return true if it has this component class
	 */
	
	public inline function hasComponent(componentClass:Class<Component>):Bool
	{
		return world.componentManager.hasComponentClass( this, componentClass);
	}
	
	/**
	 * Check if this entity has the component type.
	 * @param	type The component type.
	 * @return true if it has this component type
	 */
	
	public inline function hasComponentType(type:IComponentType):Bool
	{
		return world.componentManager.hasComponentType( this, type);
	}
	
	/**
	 * Get an iterator of all components owned by this entity.
	 * @return
	 */
	
	public inline function getComponentIterator():List<Component>
	{
		return world.componentManager.getComponents(this);
	}
	
	/**
	 * Get the type of component owned by this entity.
	 * @param	componentClass The component type you wish to retrieve.
	 * @return
	 */
	
	public inline function getComponent(componentClass:Class<Component>):Component
	{
		return world.componentManager.getComponentByClass( this, componentClass);
	}
	
	public inline function getComponentByType(componentType:IComponentType):Component
	{
		return world.componentManager.getComponentByType( this, componentType);
	}
	
	/**
	 * Remove component from this entity.
	 * @param	component
	 */
	
	public inline function removeComponent(component:Component):Void
	{
		world.componentManager.removeComponentByClass( this, Type.getClass( component));
	}
	
	/**
	 * Removes the component by type of component rather than reference.
	 * @param	componentClass
	 */
	
	public inline function removeComponentByClass(componentClass:Class<Component>):Void
	{
		world.componentManager.removeComponentByClass( this, componentClass);
	}
	
	public inline function removeComponentByType(componentType:IComponentType):Void
	{
		world.componentManager.removeComponentByType( this, componentType);
	}
	
	/**
	 * Remove component from this entity.
	 * @param	component
	 */
	
	public inline function deleteComponent(component:Component ):Void
	{
		world.componentManager.deleteComponentByClass(this, Type.getClass( component));
	}
	
	/**
	 * Removes the component by type of component rather than reference.
	 * @param	componentClass
	 */
	
	public inline function deleteComponentByClass(componentClass:Class<Component> ):Void
	{
		world.componentManager.deleteComponentByClass( this, componentClass);
	}
	
	public inline function deleteComponentByType(componentType:IComponentType ):Void
	{
		world.componentManager.deleteComponentByType( this, componentType);
	}
	
	/**
	 * Tag this entity with an Id.
	 * @param	tag the id.
	 */
	
	public inline function setTag(tag:String):Void
	{
		world.setTag(this, tag);
	}
	
	public inline function removeTag():Void
	{
		world.removeTag(this);
	}
	
	/**
	 * Get this entity's tag.
	 * @return returns null if it has not been tagged!
	 */
	
	public inline function getTag():String
	{
		return world.getTag(this);
	}
	
	/**
	 * Destroy this entity!
	 */
	
	public inline function destroy():Void
	{
		world.destroyEntity(this);
	}
	
	/**
	 * Check if this entity is active!
	 * @return
	 */
	
	private function get_isActive():Bool 
	{
		return _isActive;
	}
	
	public var isActive(get_isActive, null):Bool;
	
}