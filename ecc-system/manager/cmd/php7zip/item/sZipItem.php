<?php
class sZipItem {
	
	private $name;
	private $size;
	private $attributes;
	private $modified;
	private $extension;
	
	/**
	 * Set name of the entry. Concat directory seperator for directories
	 *
	 * @return string file name
	 */
	public function getName() {
		return ($this->isDir()) ? $this->name.DIRECTORY_SEPARATOR : $this->name;
	}
	
	/**
	 * @param unknown_type $name
	 */
	public function setName($name) {
		$this->name = $name;
	}
	
	/**
	 * @return unknown
	 */
	public function getSize() {
		return $this->size;
	}
	
	/**
	 * @param unknown_type $size
	 */
	public function setSize($size) {
		$this->size = $size;
	}
	
	/**
	 * @return unknown
	 */
	public function getModified() {
		return $this->modified;
	}
	
	/**
	 * @param unknown_type $modified
	 */
	public function setModified($modified) {
		$this->modified = $modified;
	}
	
	/**
	 * @return unknown
	 */
	public function getAttributes() {
		return $this->attributes;
	}
	
	/**
	 * @param unknown_type $attributes
	 */
	public function setAttributes($attributes) {
		$this->attributes = $attributes;
	}
	
	/**
	 * Finalize the sZipListItem
	 * An item has to be finalized. This make sure, that all informations are available
	 *
	 */
	public function finalize() {
		$this->setExtension();
	}
	
	/**
	 * It the current item a file?
	 *
	 * @return boolean
	 */
	public function isFile() {
		return (!$this->isDir()) ? true : false;
	}
	
	/**
	 * Is the current item a directory?
	 *
	 * @return boolean
	 */
	public function isDir() {
		return ($this->getAttributes() == 'D....')? true : false;
	}
	
	/**
	 * Is the current item a packed file by file extension?
	 * 
	 * Checked extensions
	 * rar
	 * ace
	 * 7z
	 * tar
	 * tar.gz
	 * 
	 * @return boolean
	 */
	public function isPackedFile() {
		if(
			$this->isZip()
			|| $this->isRar()
			|| $this->isAce()
			|| $this->is7z()
			|| $this->isTar()
			|| $this->isTarGz()
		){
			return true;
		}
		return false;
	}
	
	/**
	 * Is the current item a packed zip file by file extension?
	 *
	 * @return boolean
	 */
	public function isZip(){
		return (strtolower($this->getExtension()) == 'zip') ? true : false;
	}
	
	/**
	 * Is the current item a packed rar file by file extension?
	 *
	 * @return boolean
	 */
	public function isRar(){
		return (strtolower($this->getExtension()) == 'rar') ? true : false;
	}
	
	/**
	 * Is the current item a packed ace file by file extension?
	 *
	 * @return boolean
	 */
	public function isAce(){
		return (strtolower($this->getExtension()) == 'ace') ? true : false;
	}
	
	/**
	 * Is the current item a packed 7z file by file extension?
	 *
	 * @return boolean
	 */
	public function is7z(){
		return (strtolower($this->getExtension()) == '7z') ? true : false;
	}
	
	/**
	 * Is the current item a packed tar file by file extension?
	 *
	 * @return boolean
	 */
	public function isTar(){
		return (strtolower($this->getExtension()) == 'tar') ? true : false;
	}
	
	/**
	 * Is the current item a packed tar.gz file by file extension?
	 *
	 * @return boolean
	 */
	public function isTarGz(){
		return (strtolower($this->getExtension()) == 'tar.gz') ? true : false;
	}
	
	/**
	 * @return unknown
	 */
	public function getExtension() {
		return $this->extension;
	}
	
	/**
	 * 
	 */
	public function setExtension() {
		$this->extension = $this->extractExtension();
	}
	
	/**
	 * Extract and return the file extension, if possible!
	 *
	 * @return mixed containing file extension string, false if not found
	 */
	private function extractExtension() {
		# only extract, if this is no an directory
		if($this->isDir()) return false;
		
		# try to extract the extension, if available
		$extension = false;
		$fileName = basename($this->getName());
		if(false !== strpos($fileName, '.')){
			$split = explode('.', $fileName);
			$extension = end($split);
		}
		return $extension;
	}
	
}
?>