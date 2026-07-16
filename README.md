# 🚁 Fuzzy Logic and ANFIS-Driven Drone Navigation
### A Comparative Study with Machine Learning Models

This repository presents the complete **MATLAB** and **Simulink** implementation of an **Adaptive Neuro-Fuzzy Inference System (ANFIS)** for autonomous drone navigation and real-time obstacle avoidance.

The proposed controller combines the interpretability of **Fuzzy Logic** with the learning capability of **Artificial Neural Networks**, enabling the drone to make intelligent steering decisions using distance sensor inputs while maintaining low computational complexity.

Unlike traditional reactive obstacle avoidance methods such as **Artificial Potential Fields (APF)**, the proposed ANFIS controller minimizes local minima issues, improves navigation accuracy, and produces transparent fuzzy rules that are easily interpretable.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Research Context](#research-context)
- [Methodology](#methodology)
- [Controller Architecture](#controller-architecture)
- [Repository Structure](#repository-structure)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Simulation](#simulation)
- [Results](#results)
- [Visualizations](#visualizations)
- [Future Enhancements](#future-enhancements)
- [Citation](#citation)
- [Authors](#authors)
- [License](#license)

---

# 📖 Overview

Autonomous UAV navigation requires intelligent decision-making to safely avoid obstacles while maintaining smooth flight trajectories.

This project proposes an **Adaptive Neuro-Fuzzy Inference System (ANFIS)** controller that predicts the optimal steering angle using two distance sensor inputs:

- Front Distance
- Side Distance

The trained ANFIS controller generates the drone's **Turn Angle**, enabling real-time obstacle avoidance inside a MATLAB Simulink environment.

The project also compares ANFIS performance with several Machine Learning models including:

- Decision Tree
- Random Forest
- Support Vector Machine (SVM)
- Feedforward Neural Network

---

# 🏛️ Research Context

This work was developed by

- **Charan Karthick V**
- **Shuhash S K**

**Amrita School of Engineering, Coimbatore**

Under the guidance of

**Dr. K.R.M. Vijaya Chandrakala**

---

# 🏗️ Methodology

The complete workflow consists of four stages.

## 1️⃣ Data Collection

Synthetic obstacle avoidance data was generated representing different navigation scenarios.

Each sample consists of

- Front Distance
- Side Distance
- Turn Angle

---

## 2️⃣ Data Preprocessing

The dataset undergoes

- Data Cleaning
- Feature Selection
- Min-Max Normalization
- Dataset Partitioning

Dataset split

| Dataset | Percentage |
|----------|-----------:|
| Training | 70% |
| Validation (Checking) | 15% |
| Testing | 15% |

---

## 3️⃣ ANFIS Training

Two Fuzzy Inference System architectures are evaluated.

### Grid Partitioning (genfis1)

- 7 Generalized Bell Membership Functions
- 49 Fuzzy Rules
- Sugeno FIS

---

### Subtractive Clustering (genfis2)

- Gaussian Membership Functions
- Compact Rule Base
- 10 Fuzzy Rules

The controller is trained for **50 epochs**, and the best-performing model is automatically selected.

---

## 4️⃣ Simulation

The trained controller is integrated into a closed-loop **MATLAB Simulink** environment where the drone navigates around obstacles using live sensor inputs.

---

# 🧠 Controller Architecture

### Inputs

- Front Distance
- Side Distance

↓

### ANFIS Controller

- Membership Functions
- Fuzzy Rules
- Neural Learning

↓

### Output

- Turn Angle (Yaw Steering)

↓

### Drone Motion

- Obstacle Avoidance
- Target Navigation

---

## Architecture Diagram

Place your block diagram inside

```
assets/
```

Example

```markdown
![Architecture](assets/system_architecture.png)
```

---

# 📁 Repository Structure

```
Fuzzy-Logic-ANFIS-Drone-Navigation
│
├── assets/
│   ├── system_architecture.png
│   ├── control_surface.png
│   ├── training_error.png
│   └── simulation_result.png
│
├── dataset_cre2.m
├── best_trained_anfis.fis
├── anfis_drone_sim2.slx
├── Dataset_synthetic.mat
├── drone_fuzzy_dataset.csv
├── Drones.prj
├── README.md
└── LICENSE
```

---

# 💻 Installation

## Prerequisites

MATLAB **R2023a** (or newer)

Required Toolboxes

- Fuzzy Logic Toolbox
- Simulink
- Statistics and Machine Learning Toolbox
- Deep Learning Toolbox (for ML comparisons)

---

# 🚀 Quick Start

## Step 1 – Train the ANFIS Controller

Run

```matlab
run('dataset_cre2.m')
```

The script automatically

- Loads the dataset
- Normalizes features
- Creates genfis1 model
- Creates genfis2 model
- Trains both models
- Evaluates performance
- Selects the best controller
- Saves the trained FIS

---

## Step 2 – Load the Trained Controller

```matlab
fis = readfis('best_trained_anfis.fis');
```

---

## Step 3 – Run the Simulation

Open

```
anfis_drone_sim2.slx
```

Run the simulation.

The drone receives

- Front Distance
- Side Distance

The ANFIS controller computes

- Steering Angle

The drone autonomously avoids obstacles while moving toward the target.

---

# 📊 Results

The trained controller achieved excellent navigation performance.

## Best ANFIS Performance

| Metric | Value |
|---------|-------|
| RMSE | 11.022 |
| R² Score | 0.908 |

---

## Machine Learning Comparison

The ANFIS controller was evaluated against

- Decision Tree
- Random Forest
- Support Vector Machine
- Feedforward Neural Network

### Benchmark Performance

| Model | RMSE |
|---------|------|
| Random Forest | 0.0511 (Normalized) |
| Neural Network | 0.0694 (Normalized) |
| ANFIS | RMSE = 11.022 (Original Scale), R² = 0.908 |

Unlike conventional machine learning models, ANFIS provides interpretable fuzzy rules, making controller behavior transparent and explainable.

---

# 📈 Visualizations

## ANFIS Control Surface

```markdown
![Control Surface](assets/control_surface.png)
```

---

## Training Error

```markdown
![Training Error](assets/training_error.png)
```

---

## Drone Simulation

```markdown
![Simulation](assets/simulation_result.png)
```

---

# 🚀 Future Enhancements

- 3D Drone Navigation
- Dynamic Obstacle Avoidance
- Reinforcement Learning Integration
- ROS 2 Integration
- Gazebo Simulation
- PX4 Flight Controller Support
- Real-Time LiDAR Integration
- Multi-UAV Swarm Navigation
- Hardware-in-the-Loop (HIL) Testing
- Embedded Deployment on NVIDIA Jetson

---



---

# 👨‍💻 Authors

**Shuhash S K**

Amrita School of Engineering

Amrita Vishwa Vidyapeetham

---

# 📜 License

This project is licensed under the **MIT License**.

Contributions, suggestions, and improvements are always welcome.
