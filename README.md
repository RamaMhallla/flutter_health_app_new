# flutter_health_app_new

## ❤️ Heart Disease & Pneumonia Monitoring System

An end-to-end smart health monitoring system that predicts heart disease and detects pneumonia using both **Edge AI** and **Cloud-based ML**. Built with **Flutter**, **AWS**, and **IoT** technologies, the system provides real-time health insights and scalable remote monitoring.

---

## 🧠 Heart Disease Prediction Model

* Trained using clinical features such as:

  * Age, Gender, Chest Pain Type
  * Blood Pressure, Cholesterol
  * Max Heart Rate, Fasting Blood Sugar
* Built using **Keras** (Dense + Dropout layers)
* Converted to `.tflite` for mobile inference
* Deployed on **AWS SageMaker** for cloud inference
* Automatically switches between Edge and Cloud based on connectivity

📂 Training script:
`Heart Disease Prediction/model/train_model.py`

---

## 🩻 Pneumonia Detection from X-Ray

* Dataset: [Kaggle Chest X-ray Pneumonia](https://www.kaggle.com/datasets/paultimothymooney/chest-xray-pneumonia)
* Trained using **CNN on Google Colab**
* Images processed with `ImageDataGenerator`, resized for consistency
* Exported to TensorFlow Lite model for mobile use

📓 Notebook:
`Detecting Pneumonia using Chest X-Ray/xray_model_training.ipynb`

---

## 📱 Flutter App

* Collects patient inputs manually (age, gender, cholesterol, etc.)
* Receives real-time vitals via **MQTT** (e.g., Raspberry Pi sensors)
* Predicts health risk using:

  * Local `.tflite` model (offline)
  * Cloud-based SageMaker endpoint (online)
* Results displayed with clear risk indicators and advice
* Authenticates users via **AWS Amplify Cognito**
* Stores records in **DynamoDB** using **Amplify DataStore**
* Plans to notify doctors of high-risk patients via push/email alerts

---

## 📊 Dashboard & Analytics

* Health prediction data stored in **AWS DynamoDB**
* Visualized using **Amazon QuickSight**
* Dashboard supports:

  * Prediction distribution over time
  * Patient risk trends
  * Filter by gender, age, or risk level

---

## 🔧 AWS Services Used

* **AWS Amplify** – App backend & auth
* **AWS Cognito** – User authentication
* **AWS SageMaker** – Cloud ML inference
* **AWS Lambda + API Gateway** – Endpoint for ML requests
* **Amazon DynamoDB** – Health data storage
* **Amazon QuickSight** – Analytics and dashboards
* *(Planned)* **SNS / SES** – Notifications for doctors

---

## 🚀 How to Use

```bash
git clone https://github.com/RamaMhallla/flutter_health_app_new.git
```

1. Launch Flutter app on your mobile device/emulator
2. Sign up via Amplify Auth
3. Enter patient data manually or via MQTT
4. Get predictions (local or cloud) and view results
5. Track health history in dashboard (QuickSight)

---

