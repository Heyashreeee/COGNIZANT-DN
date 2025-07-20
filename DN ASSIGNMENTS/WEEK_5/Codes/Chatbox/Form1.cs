using Confluent.Kafka;
using System;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Chatbox
{
    public partial class Form1 : Form
    {
        private readonly IProducer<Null, string> producer;

        public Form1()
        {
            InitializeComponent();
            StartConsumer(); // 👈 Start consumer thread
            var config = new ProducerConfig { BootstrapServers = "localhost:9092" };
            producer = new ProducerBuilder<Null, string>(config).Build();
        }

        private async void button1_Click(object sender, EventArgs e)
        {
            string msg = textBox2.Text;
            if (!string.IsNullOrWhiteSpace(msg))
            {
                await producer.ProduceAsync("chat-topic", new Message<Null, string> { Value = msg });
                textBox2.Clear();
            }
        }

        private void StartConsumer()
        {
            Task.Run(() =>
            {
                var config = new ConsumerConfig
                {
                    BootstrapServers = "localhost:9092",
                    GroupId = "chatbox-consumer",
                    AutoOffsetReset = AutoOffsetReset.Earliest
                };

                using var consumer = new ConsumerBuilder<Ignore, string>(config).Build();
                consumer.Subscribe("chat-topic");

                Console.WriteLine("Kafka Consumer Started...\n");

                try
                {
                    while (true)
                    {
                        var cr = consumer.Consume(CancellationToken.None);
                        Console.WriteLine($"Received: {cr.Message.Value}");
                    }
                }
                catch (OperationCanceledException)
                {
                    consumer.Close();
                }
            });
        }
    }
}
