# **MDE Calculation – MATLAB Code**

This repository contains MATLAB scripts for calculating **Mean Distribution from Edge (MDE)** using fluorescence microscopy images. MDE quantifies the intensity-weighted spatial distribution of an organelle (or any fluorescent entity) relative to the cell edge.

---
## **📦 Setup Instructions**
### **A. Preparing the Folder Structure**

1. **Unzip all subfolders** included with this repository.
2. **Place every unzipped folder** in the **same directory** where you keep the main script: Center_mass_code.m

3. Your directory should contain:

   * Center_mass_code.m
   * Helper subfolders (functions, utilities)
   * All required `.m` files

---

## **🖼️ Input Image Requirements**

To use the MDE code, prepare the images as follows:

* **Format:** TIFF (`.tif`)
* **Channels:**

  * **Channel 1** → the entity/organelle whose **center of mass** and **MDE** you want to compute
  * **Channel 2** → a signal that enables marking the **cell boundary** and **cell edge**
* Place all TIFF images **in the same folder as the MATLAB code**.

---

## **▶️ How to Run the MDE MATLAB Code**

Open MATLAB, navigate to the folder containing all the files, and run: Center_mass_code

For each image, follow the interactive steps:

### **1. Mark the Cell ROI**
* Draw the region of interest around the cell.
* Press **Enter** when done.

### **2. Mark the Cell Edge Boundary**
* Use the cursor to **drag along the cell edge** to define the boundary facing the gap/migration direction.
* Press **Enter**.

### **3. Select the Center of the Edge**
* Click the point representing the **center** of the leading edge.
* Press **Enter**.

The script will then compute:
* The intensity-weighted center of mass of the organelle
* The minimum distance to the marked cell edge
* The **MDE value**

Results are saved automatically.
---

## **📁 Output**
The code generates:
* Center of mass coordinates
* Edge coordinates
* Calculated MDE for each image
* Optional plots (depending on your configuration)
